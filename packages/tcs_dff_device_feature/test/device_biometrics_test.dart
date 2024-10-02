import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth_windows/local_auth_windows.dart';
import 'package:mockito/mockito.dart';
import 'package:tcs_dff_device_feature/biometrics/biometrics.dart';

class MockLocalAuthentication extends Mock implements LocalAuthentication {
  MockLocalAuthentication() {
    throwOnMissingStub(this);
  }
  @override
  Future<bool> get canCheckBiometrics => super.noSuchMethod(
        Invocation.getter(#canCheckBiometrics),
        returnValue: Future<bool>.value(true),
      ) as Future<bool>;

  @override
  Future<bool> authenticate({
    required final String localizedReason,
    final Iterable<AuthMessages> authMessages = const <AuthMessages>[
      IOSAuthMessages(),
      AndroidAuthMessages(),
      WindowsAuthMessages(),
    ],
    final AuthenticationOptions options = const AuthenticationOptions(),
  }) =>
      super.noSuchMethod(
        Invocation.method(#authenticate, <Object>[], <Symbol, Object?>{
          #localizedReason: localizedReason,
          #authMessages: authMessages,
          #options: options,
        }),
        returnValue: Future<bool>.value(true),
      ) as Future<bool>;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late Biometrics biometrics;

  setUp(() {
    biometrics = Biometrics();
    Biometrics.localAuthInstance = MockLocalAuthentication();
  });

  test('authenticate with successfull biometric', () async {
    when(
      Biometrics.localAuthInstance.canCheckBiometrics,
    ).thenAnswer(
      (final _) async => true,
    );
    when(
      Biometrics.localAuthInstance.authenticate(
        localizedReason: 'Test Reason',
      ),
    ).thenAnswer(
      (final _) async => true,
    );
    final r = await biometrics.authenticate(
      localizedReason: 'Test Reason',
    );

    expect(r.isAuthenticated, true);
    expect(r.errorType, ErrorType.none);
  });
}
