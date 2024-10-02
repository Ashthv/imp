import 'package:local_auth/local_auth.dart';

class Biometrics {
  static LocalAuthentication localAuthInstance = LocalAuthentication();

  Future<AuthResponse> authenticate({
    required final String localizedReason,
    final AuthOptions options = const AuthenticationOptions(),
  }) async {
    if (!await localAuthInstance.canCheckBiometrics) {
      return AuthResponse(
        errorType: ErrorType.biometricNotAvailable,
        isAuthenticated: false,
      );
    }
    final isSuccess = await localAuthInstance.authenticate(
      localizedReason: localizedReason,
      options: options,
    );
    return AuthResponse(
      isAuthenticated: isSuccess,
      errorType: isSuccess ? ErrorType.none : ErrorType.notAuthenticated,
    );
  }
}

class AuthResponse {
  late bool isAuthenticated;
  late ErrorType errorType;
  AuthResponse({
    required this.isAuthenticated,
    required this.errorType,
  });
}

enum ErrorType {
  biometricNotAvailable,
  notAuthenticated,
  none,
}

typedef AuthOptions = AuthenticationOptions;
