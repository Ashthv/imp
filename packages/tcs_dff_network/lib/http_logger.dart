import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:tcs_dff_shared_library/logger/logger.dart';
import 'package:tcs_dff_types/exceptions.dart';

class HTTPLogger extends http.BaseClient {
  final http.Client _loggerClient;

  HTTPLogger(this._loggerClient);
  @override
  Future<http.StreamedResponse> send(final http.BaseRequest request) async {
    try {
      await requestLog(request);
      final response = await _loggerClient.send(copyRequest(request));
      final responseBody = await response.stream.bytesToString();
      await responseLog(response, responseBody);

      return http.StreamedResponse(
        http.ByteStream.fromBytes(responseBody.codeUnits),
        response.statusCode,
        contentLength: responseBody.length,
        headers: response.headers,
        request: response.request,
      );
    } catch (e) {
      ConsoleLogger().log('API exception: ${e.toString()}');
      rethrow;
    }
  }

  @visibleForTesting
  http.BaseRequest copyRequest(final http.BaseRequest request) {
    http.BaseRequest requestCopy;

    if (request is http.Request) {
      requestCopy = http.Request(request.method, request.url)
        ..encoding = request.encoding
        ..bodyBytes = request.bodyBytes;
    } else if (request is http.MultipartRequest) {
      requestCopy = http.MultipartRequest(request.method, request.url)
        ..fields.addAll(request.fields)
        ..files.addAll(request.files);
    } else {
      throw NetworkException(
        error: Error(
          title: 'Error is copying request object',
          description: 'Request type is ${request.runtimeType}, cannot copy',
        ),
        type: ExceptionType.unknown,
      );
    }

    requestCopy
      ..persistentConnection = request.persistentConnection
      ..followRedirects = request.followRedirects
      ..maxRedirects = request.maxRedirects
      ..headers.addAll(request.headers);

    return requestCopy;
  }

  @visibleForTesting
  Future requestLog(final http.BaseRequest request) async {
    final _isRequestBodyImage =
        isImageContentType(request.headers['content-type']);

    ConsoleLogger().log('Request URL: ${request.url}');
    ConsoleLogger().log('Request Header: ${request.headers}');
    if (!_isRequestBodyImage) {
      final requestBodyBytes = await request.finalize().toList();
      final requestBody = requestBodyBytes.isNotEmpty
          ? utf8.decode(requestBodyBytes.first)
          : '';
      ConsoleLogger().log('Request body: $requestBody');
    }
  }

  @visibleForTesting
  Future responseLog(
    final http.StreamedResponse response,
    final String responseBody,
  ) async {
    final _isResponseBodyImage =
        isImageContentType(response.request?.headers['content-type']);

    ConsoleLogger().log('Response URL: ${response.request?.url}');
    ConsoleLogger().log('Response Headers: ${response.headers}');

    if (!_isResponseBodyImage) {
      ConsoleLogger().log('Response  Body: $responseBody');
    }
  }

  @visibleForTesting
  bool isImageContentType(final String? contentType) {
    if (contentType != null) {
      final lowerCaseContentType = contentType.toLowerCase();
      return lowerCaseContentType.startsWith('image/');
    }
    return false;
  }
}
