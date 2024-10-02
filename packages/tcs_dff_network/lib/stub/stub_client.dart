import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:tcs_dff_types/exceptions.dart';

AssetBundle assetBundle = rootBundle;

Future<http.Response> getStubResponse<T>(
  final String stubResponseFile,
) async {
  try {
    return http.Response(
      await assetBundle.loadString(
        stubResponseFile,
      ),
      200,
    );
  } on Exception catch (e) {
    throw NetworkException(
      error: Error(
        title: e.toString(),
        description: e.toString(),
      ),
      type: ExceptionType.unknownStub,
    );
  }
}
