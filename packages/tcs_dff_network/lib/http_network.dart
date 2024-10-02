import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tcs_dff_shared_library/uncaught_error/uncaught_error.dart';
import 'package:tcs_dff_storage/cache/cache.dart';
import 'package:tcs_dff_storage/cache/cache_policy.dart';
import 'package:tcs_dff_storage/cache/cache_utils.dart';
import 'package:tcs_dff_types/config.dart';
import 'package:tcs_dff_types/tcs_dff_types.dart';

import 'http_auth_network.dart';
import 'http_network_configuration.dart';
import 'http_network_constants.dart';

class HttpNetworkPlugin implements NetworkPlugin, UncaughtErrorCallback {
  late http.Client client;
  late HTTPNetworkConfiguration networkConfiguration;
  late Cache _cache;
  Interceptor? interceptor;

  @override
  late ApplicationAuthPlugin auth;

  final Map<String, String>? _requestHeaders = {};
  HttpNetworkPlugin({
    required this.networkConfiguration,
    final ApplicationAuthPlugin? authPlugin,
    this.interceptor,
  }) {
    client = http.Client();
    _cache = Cache();
    if (authPlugin == null) {
      auth = AuthHttpNetworkPlugin(
        client: http.Client(),
        networkConfiguration: networkConfiguration,
        cache: _cache,
      );
    } else {
      auth = authPlugin;
    }
  }

  /// Set custom headers
  void _setHeaders(final Map<String, String>? headers) {
    _requestHeaders?.addAll(networkConfiguration.defaultHeaders);
    if (headers != null) {
      _requestHeaders?.addAll(headers);
    }
  }

  NetworkException _handleExceptions(final Exception e) {
    NetworkException networkException;

    switch (e) {
      case TimeoutException():
        networkException = NetworkException(
          exceptionDetails: e,
          type: ExceptionType.timeout,
          error: Error(
            title: HttpNetworkConstants.timeoutExceptionMessage,
            description: HttpNetworkConstants.timeoutExceptionMessage,
          ),
        );
        break;
      case SocketException():
        networkException = NetworkException(
          exceptionDetails: e,
          type: ExceptionType.socket,
          error: Error(
            title: HttpNetworkConstants.socketExceptionMessage,
            description: HttpNetworkConstants.socketExceptionMessage,
          ),
        );
        break;
      case IOException():
        networkException = NetworkException(
          exceptionDetails: e,
          type: ExceptionType.ioexception,
          error: Error(
            title: HttpNetworkConstants.ioExceptionMessage,
            description: HttpNetworkConstants.ioExceptionMessage,
          ),
        );
        break;
      default:
        networkException = NetworkException(
          type: ExceptionType.unknown,
          error: Error(
            title: e.toString(),
            description: e.toString(),
          ),
        );
        break;
    }
    return networkException;
  }

  Future<http.Response> _executeRequest(
    final Future<http.Response> Function() request, {
    final CachePolicy? cachePolicy,
  }) async {
    try {
      final response = await request();
      updateDataToCache(cachePolicy, response.body);
      return response;
    } on Exception catch (e) {
      throw _handleExceptions(e);
    }
  }

  @override
  Future<http.Response> delete({required final ApiConfig apiConfig}) async {
    _setHeaders(apiConfig.headers);

    Future<http.Response> request() async => await client.delete(
          apiConfig.url,
          headers: _requestHeaders,
          body: apiConfig.body,
          encoding: apiConfig.encoding,
        );
    return _executeRequest(request);
  }

  @override
  Future<http.Response> get({required final ApiConfig apiConfig}) async {
    Future<http.Response> request(final ApiConfig apiConfig) async => _get(
          apiConfig: apiConfig,
        );
    return handleHttpRequest(request, apiConfig);
  }

  Future<http.Response> _get({required final ApiConfig apiConfig}) {
    _setHeaders(apiConfig.headers);

    Future<http.Response> request() async => await client.get(
          apiConfig.url,
          headers: _requestHeaders,
        );
    return _executeRequest(request, cachePolicy: apiConfig.cachePolicy);
  }

  @override
  Future<http.Response> head({required final ApiConfig apiConfig}) async {
    _setHeaders(apiConfig.headers);
    Future<http.Response> request() async => await client.head(
          apiConfig.url,
          headers: _requestHeaders,
        );

    return _executeRequest(request);
  }

  @override
  Future<http.Response> patch({required final ApiConfig apiConfig}) async {
    _setHeaders(apiConfig.headers);
    Future<http.Response> request() async => await client.patch(
          apiConfig.url,
          headers: _requestHeaders,
          body: json.encode(apiConfig.body),
          encoding: apiConfig.encoding,
        );
    return _executeRequest(request);
  }

  @override
  Future<http.Response> post({required final ApiConfig apiConfig}) async {
    Future<http.Response> request(final ApiConfig apiConfig) async => _post(
          apiConfig: apiConfig,
        );
    return handleHttpRequest(request, apiConfig);
  }

  Future<http.Response> _post({required final ApiConfig apiConfig}) async {
    _setHeaders(apiConfig.headers);
    Future<http.Response> request() async => await client.post(
          apiConfig.url,
          headers: _requestHeaders,
          body: json.encode(apiConfig.body),
          encoding: apiConfig.encoding,
        );
    return _executeRequest(request, cachePolicy: apiConfig.cachePolicy);
  }

  Future<http.Response> handleHttpRequest(
    final Future<http.Response> Function(ApiConfig apiConfig) request,
    final ApiConfig apiConfig,
  ) async {
    final data = await getDataFromCache(apiConfig);
    if (data == null) {
      return request(apiConfig);
    } else {
      if (apiConfig.cachePolicy.policy == Policy.cacheFirst) {
        unawaited(request(apiConfig));
      }
      return http.Response(data, HttpNetworkConstants.statusCodeSuccess);
    }
  }

  Future<String?> getDataFromCache(final ApiConfig apiConfig) async {
    if (apiConfig.cachePolicy.policy == Policy.networkOnly) {
      return null;
    }
    return _cache.getItem(
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
        _cache.setItem(
          key: cachePolicy.storageKey,
          data: data,
          expiryTime: cachePolicy.expiry,
        );
      }
    }
  }

  @override
  Future<http.Response> put({required final ApiConfig apiConfig}) async {
    _setHeaders(apiConfig.headers);
    Future<http.Response> request() async => await client.put(
          apiConfig.url,
          headers: _requestHeaders,
          body: json.encode(apiConfig.body),
          encoding: apiConfig.encoding,
        );
    return _executeRequest(request);
  }

  @override
  Future<String> read({required final ApiConfig apiConfig}) async {
    _setHeaders(apiConfig.headers);
    return client.read(apiConfig.url, headers: _requestHeaders);
  }

  @override
  Future<Uint8List> readBytes({required final ApiConfig apiConfig}) async {
    _setHeaders(apiConfig.headers);
    return client.readBytes(apiConfig.url, headers: _requestHeaders);
  }

  @override
  Future<http.StreamedResponse> send({
    required final http.BaseRequest request,
  }) async {
    request.headers.addAll(_requestHeaders!);
    return await client.send(request);
  }

  @override
  Future<bool> isInternetAvaiable() async {
    const isConnected = true;
    // try {
    //   final result = await InternetAddress.lookup('google.com');
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //     isConnected = true;
    //   }
    // } on SocketException catch (_) {
    //   isConnected = false;
    // }
    return isConnected;
  }

  @override
  Future<void> init() async {
    UncaughtError().registerListener(this);
  }

  @override
  Future<void> release() async {
    client.close();
    UncaughtError().unregisterListener(this);
  }

  @override
  void flutterErrorCallback(final FlutterErrorDetails errorDetails) {}

  @override
  void platformErrorCallback(
    final Object exception,
    final StackTrace stackTrace,
  ) {
    if (exception is NetworkException) {
      interceptor?.callback(exception, stackTrace);
    }
  }
}
