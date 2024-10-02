import 'package:http/http.dart' as http;
import '../config.dart';
import '../tcs_dff_types.dart';

abstract interface class ApplicationAuthPlugin implements NetworkPlugin {
  Future<http.Response> initiateSession({
    required final ApiConfig apiConfig,
  });

  void clearSession();

  Future<http.Response> login({
    required final ApiConfig apiConfig,
  });

  Future<bool> isloggedIn();

  Future<http.Response> logout({
    required final ApiConfig apiConfig,
  });
}
