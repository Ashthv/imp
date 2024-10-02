import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:tcs_dff_network/http_logger.dart';
import 'package:tcs_dff_types/tcs_dff_types.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('http_logger test', () {
    late HTTPLogger httpLogger;

    setUp(() {
      httpLogger = HTTPLogger(http.Client());
    });

    test('isImageContentType cases', () {
      var isImageContentType = httpLogger.isImageContentType(null);
      expect(isImageContentType, false);

      isImageContentType = httpLogger.isImageContentType('dummy');
      expect(isImageContentType, false);

      isImageContentType = httpLogger.isImageContentType('image/jpeg');
      expect(isImageContentType, true);

      isImageContentType = httpLogger.isImageContentType('dummyimage/jpeg');
      expect(isImageContentType, false);
    });

    test('responseLog method call', () {
      const responseBody = 'Sample response body';
      final controller = StreamController<List<int>>(sync: true);
      final streamedResponse = http.StreamedResponse(
        controller.stream,
        200,
        request: http.Request(
          'methodName',
          Uri(
            scheme: 'https',
            host: 'hostId',
            path: 'URL',
          ),
        ),
        headers: {'content-type': 'image/png'},
      );

      unawaited(controller.close());

      final response = httpLogger.responseLog(streamedResponse, responseBody);

      expect(response, isA<Future<void>>());
      expect(response, isNot(Exception));
    });

    test('requestLog method call', () {
      final request = http.Request(
        'methodName',
        Uri(
          scheme: 'https',
          host: 'hostId',
          path: 'URL',
        ),
      )..headers.addAll({'content-type': 'image/png'});

      final response = httpLogger.requestLog(request);

      expect(response, isA<Future<void>>());
      expect(response, isNot(Exception));
    });

    test('requestLog method call with isRequestBodyImage as false', () {
      final request = http.Request(
        'methodName',
        Uri(
          scheme: 'https',
          host: 'hostId',
          path: 'URL',
        ),
      )..headers.addAll({'content-type': 'content/json'});

      final response = httpLogger.requestLog(request);

      expect(response, isA<Future<void>>());
      expect(response, isNot(Exception));
    });

    test('send method call', () async {
      final client =
          MockClient.streaming((final request, final bodyStream) async {
        final bodyString = await bodyStream.bytesToString();
        final stream =
            Stream.fromIterable(['Request body was "$bodyString"'.codeUnits]);
        return http.StreamedResponse(stream, 200);
      });

      final httpLoger = HTTPLogger(client);

      final uri = Uri.http('example.com', '/foo');
      final request = http.Request('POST', uri)
        ..body = 'hello, world'
        ..headers.addAll({'content-type': 'image/png'});
      final streamedResponse = await httpLoger.send(request);
      final response = await http.Response.fromStream(streamedResponse);
      expect(response.body, equals('Request body was "hello, world"'));
    });

    test('copyRequest method call', () {
      final uri = Uri.http('example.com', '/foo');
      final request = http.Request('POST', uri)
        ..body = 'hello, world'
        ..headers.addAll({'content-type': 'image/png'});
      final requestCopy = httpLogger.copyRequest(request);

      expect(requestCopy.headers, request.headers);
      expect(requestCopy.url, request.url);
      expect(requestCopy.method, request.method);
      expect(requestCopy.persistentConnection, request.persistentConnection);
      expect(requestCopy.followRedirects, request.followRedirects);
      expect(requestCopy.maxRedirects, request.maxRedirects);
    });

    test('copyRequest method call with MultipartRequest', () {
      final uri = Uri.http('example.com', '/foo');
      final request = http.MultipartRequest('POST', uri)
        ..headers.addAll({'content-type': 'image/png'});
      final requestCopy = httpLogger.copyRequest(request);

      expect(requestCopy.headers, request.headers);
      expect(requestCopy.url, request.url);
      expect(requestCopy.method, request.method);
      expect(requestCopy.persistentConnection, request.persistentConnection);
      expect(requestCopy.followRedirects, request.followRedirects);
      expect(requestCopy.maxRedirects, request.maxRedirects);
    });

    test('copyRequest method call with StreamedRequest', () {
      final uri = Uri.http('example.com', '/foo');
      final request = http.StreamedRequest('POST', uri)
        ..headers.addAll({'content-type': 'image/png'});

      try {
        httpLogger.copyRequest(request);
      } on NetworkException catch (_) {
        expect(_.type, ExceptionType.unknown);
      } catch (e) {
        fail('Unexpected exception: $e');
      }
    });

    test('copyRequest method call with some other request', () {
      final uri = Uri.http('example.com', '/foo');
      final request = http.StreamedRequest('POST', uri)
        ..headers.addAll({'content-type': 'image/png'});

      try {
        httpLogger.copyRequest(request);
      } on NetworkException catch (_) {
        expect(_.type, ExceptionType.unknown);
      } catch (e) {
        fail('Unexpected exception: $e');
      }
    });
  });
}
