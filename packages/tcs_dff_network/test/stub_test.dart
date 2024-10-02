import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tcs_dff_network/stub/stub_client.dart';
import 'package:tcs_dff_types/exceptions.dart';

class MockRootBundle extends Mock implements PlatformAssetBundle {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('getStubResponse', () {
    late MockRootBundle mockRootBundle;

    setUp(() {
      mockRootBundle = MockRootBundle();
      assetBundle = mockRootBundle;
    });

    test('returns with stub data when successful', () async {
      const stubResponseFile = 'path/to/stub.json';
      const stubData = '{"key": "value"}';
      when(() => mockRootBundle.loadString(stubResponseFile))
          .thenAnswer((final _) async => stubData);

      final response =
          await getStubResponse<Map<String, dynamic>>(stubResponseFile);

      expect(response.statusCode, equals(200));
      expect(response.body, equals(stubData));
    });

    test('throws NetworkException when exception occurs', () async {
      const stubResponseFile = 'path/to/invalid_stub.json';
      when(() => mockRootBundle.loadString(stubResponseFile))
          .thenThrow(Exception('Failed to load stub'));

      expect(
        () async =>
            await getStubResponse<Map<String, dynamic>>(stubResponseFile),
        throwsA(
          isA<NetworkException>().having(
            (final e) => e.type,
            'type',
            equals(ExceptionType.unknownStub),
          ),
        ),
      );
    });
  });
}
