// ignore_for_file: avoid_dynamic_calls

import 'dart:io';

import 'package:tcs_dff_shared_library/logger/logger.dart';
import 'package:tcs_dff_storage/cache/cache_policy.dart';
import 'package:tcs_dff_storage/cache/cache_utils.dart';
import 'package:tcs_dff_types/config.dart';
import 'package:tcs_dff_types/tcs_dff_types.dart';

class HTTPService {
  HTTPService();

  //final httpNetwork = HttpNetworkPlugin();
  final loginBody = {
    'body': {
      'AuthenticationType': 'CredentialAuth',
      'UserType': 'CUSTOMER',
      'LoginParams': [
        'CredLogin',
        'sbiuser',
        '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4',
        'wldeviceid-1',
        'imei-1-1',
        '1',
        'Android',
        'ok',
        'gcm-1',
        '10.3',
        'lat',
        'long',
        'N',
        'N',
        'N',
        'ICICIRET',
        '0',
      ],
    },
  };
  final Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/posts/');
  final Uri sessionUrl = Uri.parse(
    'http://10.10.213.33:91/SBIYONOGateway/GATEWAY/SERVICES/security/generateSessionToken',
  );

  final loginUrl = Uri.parse(
    'http://10.10.213.33:91/SBIGateway/GATEWAY/SERVICES/security/Login',
  );
  Future httpCall(final String requestType) async {
    switch (requestType) {
      case 'GET':
        try {
          final config = ApiConfig(
            url: uri,
            cachePolicy: CachePolicy(
              storageKey: 'sampleData',
              expiry: getExpiryDate(duration: const Duration(seconds: 30)),
              policy: Policy.cacheOnly,
            ),
          );
          final response = await dff.network.auth.get(
            apiConfig: config,
          );

          //ConsoleLogger().log(response.body);
          if (response.statusCode != 200) {
            ConsoleLogger().log(response.body);
          }
          return _apiResultFor(requestType, response);
        } on NetworkException catch (exception) {
          ConsoleLogger().error(exception.exceptionDetails.toString());
          return _apiExceptionFor(
            requestType,
            _getExceptionDetails(exception),
            exception.error.title,
          );
        } on AuthorizationException catch (exception) {
          return _apiExceptionFor(
            requestType,
            exception.exceptionDetails != null
                ? exception.exceptionDetails.toString()
                : exception.error.description,
            exception.error.title,
          );
        } catch (exception) {
          ConsoleLogger().error(exception.toString());
          return _apiExceptionFor(requestType, exception.toString(), '');
        }
      case 'POST':
        try {
          final config = ApiConfig(
            url: uri,
            body: {
              'userId': 100,
              'id': 200,
              'title': 'Testing from Flutter',
              'body': 'This is testing for post method',
            },
            cachePolicy: CachePolicy(
              storageKey: 'sampleData',
              expiry: getExpiryDate(duration: const Duration(minutes: 30)),
              policy: Policy.cacheOnly,
            ),
          );

          final response = await dff.network.auth.post(apiConfig: config);

          return _apiResultFor(requestType, response);
        } on NetworkException catch (exception) {
          ConsoleLogger().log('exception: ${exception.toString()}');
          return _apiExceptionFor(
            requestType,
            _getExceptionDetails(exception),
            exception.error.title,
          );
        } catch (exception) {
          ConsoleLogger().log('error:${exception.toString()}');
          return _apiExceptionFor(requestType, exception.toString(), '');
        }

      case 'PUT':
        try {
          final config = ApiConfig(
            url: uri,
            body: {
              'userId': 100,
              'id': 200,
              'title': 'Testing from Flutter',
              'body': 'This is testing for post method',
            },
          );
          final response = await dff.network.put(apiConfig: config);
          return _apiResultFor(requestType, response);
        } on NetworkException catch (exception) {
          return _apiExceptionFor(
            requestType,
            _getExceptionDetails(exception),
            exception.error.title,
          );
        } catch (exception) {
          return _apiExceptionFor(requestType, exception.toString(), '');
        }
      case 'DELETE':
        try {
          final config = ApiConfig(
            url: uri,
            body: {
              'userId': 100,
              'id': 200,
              'title': 'Testing from Flutter',
              'body': 'This is testing for post method',
            },
          );
          final response = await dff.network.delete(apiConfig: config);
          return _apiResultFor(requestType, response);
        } on NetworkException catch (exception) {
          return _apiExceptionFor(
            requestType,
            _getExceptionDetails(exception),
            exception.error.title,
          );
        } catch (exception) {
          return _apiExceptionFor(requestType, exception.toString(), '');
        }
      case 'HEAD':
        try {
          final config = ApiConfig(url: uri);
          final response = await dff.network.head(apiConfig: config);
          return _apiResultFor(requestType, response);
        } on NetworkException catch (exception) {
          return _apiExceptionFor(
            requestType,
            _getExceptionDetails(exception),
            exception.error.title,
          );
        } catch (exception) {
          return _apiExceptionFor(requestType, exception.toString(), '');
        }
      case 'SEND':
        try {
          final httpMultipartRequest = HttpMultipartRequest('POST', uri);
          final httpMultipartFile =
              HttpMultipartFile('file', File('/path/text'));
          // 'file' would be the field_name/parameter that service is going to accept
          httpMultipartRequest.files
              .add(await httpMultipartFile.toMultipartFile());
          final response =
              await dff.network.send(request: httpMultipartRequest);
          return _apiResultFor('POST', response);
        } on NetworkException catch (exception) {
          return _apiExceptionFor(
            requestType,
            _getExceptionDetails(exception),
            exception.error.title,
          );
        } catch (exception) {
          return _apiExceptionFor(requestType, exception.toString(), '');
        }
      case 'LOGIN_TEST':
        try {
          final config = ApiConfig(url: sessionUrl, body: {});

          final response = await dff.network.auth.login(apiConfig: config);
          return _apiResultFor(requestType, response);
        } on NetworkException catch (exception) {
          return _apiExceptionFor(
            requestType,
            _getExceptionDetails(exception),
            exception.error.title,
          );
        } catch (exception) {
          return _apiExceptionFor(requestType, exception.toString(), '');
        }
      case 'LOGOUT_TEST':
        try {
          final config = ApiConfig(url: sessionUrl, body: {});

          final response = await dff.network.auth.logout(apiConfig: config);
          return _apiResultFor(requestType, response);
        } on NetworkException catch (exception) {
          return _apiExceptionFor(
            requestType,
            _getExceptionDetails(exception),
            exception.error.title,
          );
        } catch (exception) {
          return _apiExceptionFor(requestType, exception.toString(), '');
        }
      default:
        return 'Invalid request type';
    }
  }

  String _apiExceptionFor(
    final String requestType,
    final String exception,
    final String? message,
  ) =>
      'Request: $requestType \nException : $exception \n $message';

  String _apiResultFor(final String requestType, final response) {
    if (response.statusCode == 200) {
      return _apiSuccessResult(requestType, response.body as String);
    } else {
      return _apiFailureResult(
        requestType,
        response.statusCode as int,
        response.body as String,
      );
    }
  }

  String _apiSuccessResult(
    final String requestType,
    final String responseBody,
  ) {
    final response =
        'Request: $requestType \nsuccuess \nResponse: $responseBody';
    return response;
  }

  String _apiFailureResult(
    final String requestType,
    final int statusCode,
    final String responseBody,
  ) =>
      'Request: $requestType \nFailure: $statusCode \nResponse: $responseBody';

  String _getExceptionDetails(final NetworkException exception) =>
      exception.exceptionDetails != null
          ? exception.exceptionDetails.toString()
          : exception.error.description;
}
