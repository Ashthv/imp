import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tcs_dff_storage/cache/cache.dart';
import 'package:tcs_dff_storage/cache/cache_policy.dart';
import 'package:tcs_dff_storage/cache/cache_utils.dart';
import 'package:tcs_dff_types/base_request.dart';
import 'package:tcs_dff_types/config.dart';
import 'package:tcs_dff_types/tcs_dff_types.dart';

import 'cache_manager.dart';
import 'encryption_manager.dart';
import 'http_logger.dart';
import 'http_network_configuration.dart';
import 'http_network_constants.dart';
import 'stub/stub_client.dart';

class AuthHttpNetworkPlugin implements ApplicationAuthPlugin {
  http.Client _client;
  late HTTPNetworkConfiguration networkConfiguration;
  final EncryptionManager _encryptionManager = EncryptionManager();
  @override
  late ApplicationAuthPlugin auth;
  late Cache cache;
  late CacheManager cacheManager;

  AuthHttpNetworkPlugin({
    required final http.Client client,
    required this.networkConfiguration,
    required this.cache,
  })  : _client =
            networkConfiguration.showLogs && networkConfiguration.isDebugBuild
                ? HTTPLogger(client)
                : client,
        cacheManager = CacheManager.defaultInit();

  Future<String?> _getSessionToken() async => await cache.getSecuredItem(
        key: HttpNetworkConstants.sessionTokenCollectionKey,
      );

  Future<void> _saveSessionToken(final String sessionToken) async {
    await cache.setSecuredItem(
      key: HttpNetworkConstants.sessionTokenCollectionKey,
      data: sessionToken,
    );
  }

  Future<String?> _getAuthToken() async => await cache.getSecuredItem(
        key: HttpNetworkConstants.authTokenKey,
      );

  Future<void> _saveAuthToken(final String jwtToken) async {
    await cache.setSecuredItem(
      key: HttpNetworkConstants.authTokenKey,
      data: jwtToken,
    );
  }

  /// Set  headers
  Future<Map<String, String>> _getHeaders({
    final Map<String, String>? headers,
  }) async {
    final _requestHeaders = <String, String>{}
      ..addAll(networkConfiguration.defaultHeaders);

    if (headers != null) {
      _requestHeaders.addAll(headers);
    }
    final map = await retriveAuthHeaders() as Map<String, String>;
    if (map.isNotEmpty) {
      _requestHeaders.addAll(map);
    }
    return _requestHeaders;
  }

  NetworkException _handleExceptions(final Exception e) {
    NetworkException networkException;

    switch (e) {
      case NetworkException():
        return e;
      case TimeoutException():
        networkException = NetworkException(
          error: Error(
            title: HttpNetworkConstants.timeoutExceptionMessage,
            description: HttpNetworkConstants.timeoutExceptionMessage,
          ),
          exceptionDetails: e,
          type: ExceptionType.timeout,
        );
        break;
      case SocketException():
        networkException = NetworkException(
          error: Error(
            title: HttpNetworkConstants.socketExceptionMessage,
            description: HttpNetworkConstants.socketExceptionMessage,
          ),
          exceptionDetails: e,
          type: ExceptionType.socket,
        );
        break;
      case IOException():
        networkException = NetworkException(
          error: Error(
            title: HttpNetworkConstants.ioExceptionMessage,
            description: HttpNetworkConstants.ioExceptionMessage,
          ),
          exceptionDetails: e,
          type: ExceptionType.ioexception,
        );
        break;
      case AuthorizationException():
        networkException = NetworkException(
          error: Error(
            description: e.error.description,
            title: HttpNetworkConstants.authExceptionMessage,
          ),
          exceptionDetails: e,
          type: ExceptionType.authorization,
        );
        break;
      default:
        networkException = NetworkException(
          error: Error(
            title: e.toString(),
            description: e.toString(),
          ),
          type: ExceptionType.unknown,
        );
        break;
    }
    return networkException;
  }

  @visibleForTesting
  Future<http.Response> executeRequest(
    final Future<http.Response> Function() request, {
    required final int retry,
    final CachePolicy? cachePolicy,
    Duration? timeOut,
  }) async {
    timeOut ??= networkConfiguration.timeOut;
    try {
      final response = await request().timeout(
        timeOut,
        onTimeout: () => throw NetworkException(
          error: Error(
            title: HttpNetworkConstants.requestTimeoutMessage,
            description: HttpNetworkConstants.requestTimeoutMessage,
          ),
          type: ExceptionType.timeout,
        ),
      );

      if (response.statusCode == 403) {
        if (!await isloggedIn()) {
          await initiateSession(
            apiConfig: ApiConfig(
              url: Uri.parse(networkConfiguration.sessionTokenUrl),
              body: {},
            ),
          );
        } else {
          await _refreshAccessToken();
          return await executeRequest(
            request,
            retry: retry,
            timeOut: timeOut,
          );
        }
      }

      if (response.statusCode == 200) {
        updateDataToCache(cachePolicy, response.body);
        return await _decryptResponseBody(response);
      }
      if (retry > 0) {
        return await executeRequest(
          request,
          retry: retry - 1,
          timeOut: timeOut,
        );
      }

      throw Exception(response.body);
    } on Exception catch (e) {
      throw _handleExceptions(e);
    }
  }

  Future<void> _refreshAccessToken() async {
    try {
      // complete request below will change inclues exceptions.

      // refresh token url should be hit with refreshToken as header which we
      // will get from Login response.
      // If session token expires, user needs to login again.
      final response = await _client.post(
        Uri.parse(
          networkConfiguration.refreshTokenURL!,
        ),
        headers: await _getHeaders(),
        body: json.encode(
          {
            HttpNetworkConstants.sessionTokenCollectionKey: _getRefreshToken(),
            // it should be Access token
          },
        ),
      );

      if (response.statusCode == 200) {
        final sessionToken = response.headers['authorization'] as String;
        await _saveAuthToken(sessionToken);
      } else {
        throw AuthorizationException(
          error: Error(
            description: response.body,
            title: HttpNetworkConstants.authExceptionMessage,
          ),
        );
      }
    } on Exception catch (exception) {
      throw _handleExceptions(exception);
    }
  }

  @override
  Future<http.Response> get({
    required final ApiConfig apiConfig,
  }) async {
    Future<http.Response> request(final ApiConfig apiConfig) async => _get(
          apiConfig: apiConfig,
        );

    return handleHttpRequest(request, apiConfig);
  }

  Future<http.Response> handleHttpRequest(
    final Future<http.Response> Function(ApiConfig apiConfig) request,
    final ApiConfig apiConfig,
  ) async {
    final data = await getDataFromCache(apiConfig);
    if (data == null || data.isEmpty) {
      return request(apiConfig);
    } else {
      if (apiConfig.cachePolicy.policy == Policy.cacheFirst) {
        unawaited(request(apiConfig));
      }
      return http.Response(data, HttpNetworkConstants.statusCodeSuccess);
    }
  }

  Future<http.Response> _get({
    required final ApiConfig apiConfig,
  }) async {
    Future<http.Response> request() async => await _client.get(
          apiConfig.url,
          headers: await _getHeaders(
            headers: apiConfig.headers,
          ),
        );
    return executeRequest(
      request,
      cachePolicy: apiConfig.cachePolicy,
      retry: apiConfig.retry,
      timeOut: apiConfig.timeOut,
    );
  }

  @override
  Future<http.Response> delete({
    required final ApiConfig apiConfig,
  }) async {
    Future<http.Response> request() async => await _client.delete(
          apiConfig.url,
          headers: await _getHeaders(
            headers: apiConfig.headers,
          ),
          body: json.encode(await _encryptRequestBody(apiConfig.body)),
          encoding: apiConfig.encoding,
        );
    return executeRequest(
      request,
      retry: apiConfig.retry,
      timeOut: apiConfig.timeOut,
    );
  }

  @override
  Future<http.Response> head({required final ApiConfig apiConfig}) async {
    Future<http.Response> request() async => await _client.head(
          apiConfig.url,
          headers: await _getHeaders(
            headers: apiConfig.headers,
          ),
        );

    return executeRequest(
      request,
      retry: apiConfig.retry,
      timeOut: apiConfig.timeOut,
    );
  }

  @override
  Future<http.Response> patch({required final ApiConfig apiConfig}) async {
    Future<http.Response> request() async => await _client.patch(
          apiConfig.url,
          headers: await _getHeaders(
            headers: apiConfig.headers,
          ),
          body: json.encode(await _encryptRequestBody(apiConfig.body)),
          encoding: apiConfig.encoding,
        );
    return executeRequest(
      request,
      retry: apiConfig.retry,
      timeOut: apiConfig.timeOut,
    );
  }

  @override
  Future<http.Response> post({required final ApiConfig apiConfig}) async {
    if (networkConfiguration.stubEnabled && apiConfig.stubConfig != null) {
      return await getStubResponse(
        apiConfig.stubConfig!.jsonFilePath,
      );
    }

    Future<http.Response> request(final ApiConfig apiConfig) async => _post(
          apiConfig: apiConfig,
        );
    return handleHttpRequest(request, apiConfig);
  }

  Future<String?> getDataFromCache(final ApiConfig apiConfig) async {
    if (apiConfig.cachePolicy.policy == Policy.networkOnly) {
      return null;
    }
    return cache.getItem(
      key: apiConfig.cachePolicy.storageKey,
    );
  }

  void updateDataToCache(
    final CachePolicy? cachePolicy,
    final String data,
  ) {
    if (cachePolicy != null) {
      if (cachePolicy.policy == Policy.cacheFirst ||
          cachePolicy.policy == Policy.cacheOnly) {
        cache.setItem(
          key: cachePolicy.storageKey,
          data: data,
          expiryTime: cachePolicy.expiry,
        );
      }
    }
  }

  Future<http.Response> _post({required final ApiConfig apiConfig}) async {
    Future<http.Response> request() async => await _client.post(
          apiConfig.url,
          headers: await _getHeaders(
            headers: apiConfig.headers,
          ),
          body: json.encode(
            await _encryptRequestBody(
              BaseRequest(
                headers: await cacheManager.getRequestHeaders(),
                body: apiConfig.body!,
                // body: apiConfig.body ?? {},
              ),
            ),
          ),
          encoding: apiConfig.encoding,
        );
    return executeRequest(
      request,
      retry: apiConfig.retry,
      timeOut: apiConfig.timeOut,
      cachePolicy: apiConfig.cachePolicy,
    );
  }

  @override
  Future<http.Response> put({required final ApiConfig apiConfig}) async {
    Future<http.Response> request() async => await _client.put(
          apiConfig.url,
          headers: await _getHeaders(
            headers: apiConfig.headers,
          ),
          body: json.encode(await _encryptRequestBody(apiConfig.body)),
          encoding: apiConfig.encoding,
        );
    return executeRequest(
      request,
      retry: apiConfig.retry,
      timeOut: apiConfig.timeOut,
    );
  }

  @override
  Future<String> read({required final ApiConfig apiConfig}) async =>
      _client.read(
        apiConfig.url,
        headers: await _getHeaders(
          headers: apiConfig.headers,
        ),
      );

  @override
  Future<Uint8List> readBytes({required final ApiConfig apiConfig}) async =>
      _client.readBytes(
        apiConfig.url,
        headers: await _getHeaders(
          headers: apiConfig.headers,
        ),
      );

  @override
  Future<http.StreamedResponse> send({
    required final http.BaseRequest request,
  }) async {
    //request.headers.addAll(defaultHeaders);
    request.headers.addAll(networkConfiguration.defaultHeaders);
    Future<http.StreamedResponse> sendRequest() async =>
        await _client.send(request);
    return _executeStreamedRequest(sendRequest);
  }

  Future<http.StreamedResponse> _executeStreamedRequest(
    final Future<http.StreamedResponse> Function() sendRequest,
  ) async {
    try {
      final response = await sendRequest();
      if (response.statusCode == 403) {
        await _refreshAccessToken();
        return _executeStreamedRequest(sendRequest);
      }
      return response;
    } on Exception catch (exception) {
      throw _handleExceptions(exception);
    }
  }

  @override
  Future<void> init() async {}

  @override
  Future<void> release() async {}

  @override
  Future<bool> isloggedIn() async {
    final authToken = await _getAuthToken();
    if (authToken != null && authToken.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Future<http.Response> login({required final ApiConfig apiConfig}) async {
    final response = await post(apiConfig: apiConfig);

    if (response.statusCode == 200) {
      try {
        await _saveAuthToken(response.headers['authorization'] as String);
      } catch (e) {
        throw NetworkException(
          error: Error(
            title: e.toString(),
            description: e.toString(),
          ),
          type: ExceptionType.unknown,
        );
      }
    }
    return response;
  }
  // we will also need to store Refresh Token

  @override
  Future<http.Response> logout({
    required final ApiConfig apiConfig,
  }) async {
    final response = await post(apiConfig: apiConfig);

    if (response.statusCode == 200) {
      clearSession();
    }
    return response;
  }

  Future<Map> retriveAuthHeaders() async {
    final map = <String, String>{};
    String? token;
    if (!await isloggedIn()) {
      token = await _getSessionToken();
      if (token == null || token.isEmpty) {
        await initiateSession(
          apiConfig: ApiConfig(
            url: Uri.parse(networkConfiguration.sessionTokenUrl),
            body: {},
          ),
        );
        token = await _getSessionToken();
      }
    } else {
      token = await _getAuthToken();
    }

    if (token != null && token.isNotEmpty) {
      map['Authorization'] = token;
    }
    return map;
  }

  @override
  void clearSession() {
    cache
      ..deleteCacheItem(HttpNetworkConstants.authTokenKey)
      ..deleteCacheItem(HttpNetworkConstants.sessionTokenCollectionKey);

    // to clean complete cache collection, we can call below method
    // cache.clearCache();
  }

  @override
  Future<http.Response> initiateSession({
    required final ApiConfig apiConfig,
  }) async {
    final _requestHeaders = <String, String>{}
      ..addAll(networkConfiguration.defaultHeaders);
    if (apiConfig.headers != null) {
      _requestHeaders.addAll(apiConfig.headers!);
    }

    var encryptedHeaderKeys = <String, String>{};
    if (networkConfiguration.enableEncryption) {
      encryptedHeaderKeys =
          await _encryptionManager.generateEncryptedHeaderKeys(
        networkConfiguration,
      );
      _requestHeaders.addAll(
        {
          'AES-HKey': encryptedHeaderKeys['aesEncryptedHKey']!,
          'AES-BKey': encryptedHeaderKeys['aesEncryptedBKey']!,
        },
      );
    }

    Future<http.Response> request() async => _client.post(
          apiConfig.url,
          headers: _requestHeaders,
          body: json.encode(
            apiConfig.body,
          ),
          //encoding: encoding,
        );

    final response = await executeRequest(
      request,
      retry: apiConfig.retry,
      timeOut: apiConfig.timeOut,
    );

    if (response.statusCode == 200) {
      try {
        await _saveSessionToken(response.headers['authorization'] as String);
      } catch (e) {
        throw NetworkException(
          error: Error(
            title: e.toString(),
            description: e.toString(),
          ),
          type: ExceptionType.unknown,
        );
      }
      if (networkConfiguration.enableEncryption) {
        _encryptionManager.saveEncryptedKeys(encryptedHeaderKeys);
      }
    }
    return response;
  }

  @override
  Future<bool> isInternetAvaiable() async {
    throw UnimplementedError();
  }

  //Encrypt the request body data
  Future<Object?> _encryptRequestBody(final Object? requestBody) async {
    if (networkConfiguration.enableEncryption && requestBody != null) {
      return await _encryptionManager.encryptBodyData(requestBody);
    }
    return requestBody;
  }

//Decrypt the response body data
  Future<http.Response> _decryptResponseBody(
    final http.Response response,
  ) async {
    if (networkConfiguration.enableEncryption &&
        json.decode(response.body).toString().isNotEmpty) {
      final decryptedBody = await _encryptionManager.decryptBodyData(
        json.decode(response.body) as Object,
      );
      return http.Response(
        decryptedBody.toString(),
        response.statusCode,
        request: response.request,
        headers: response.headers,
        persistentConnection: response.persistentConnection,
        reasonPhrase: response.reasonPhrase,
      );
    }
    return response;
  }

  // declared for Future use
  String _getRefreshToken() => 'dummyToken';

  @visibleForTesting
  void setHttpClient(final http.Client client) {
    _client = client;
  }
}
