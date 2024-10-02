import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import '../config.dart';
import '../tcs_dff_types.dart';

abstract interface class NetworkPlugin implements Plugin {
  late ApplicationAuthPlugin auth;

  Future<bool> isInternetAvaiable();

  Future<http.Response> get({
    required final ApiConfig apiConfig,
  });

  Future<http.Response> post({
    required final ApiConfig apiConfig,
  });

  Future<http.Response> patch({
    required final ApiConfig apiConfig,
  });

  Future<http.Response> delete({
    required final ApiConfig apiConfig,
  });

  Future<http.Response> put({
    required final ApiConfig apiConfig,
  });

  Future<String> read({
    required final ApiConfig apiConfig,
  });

  Future<http.Response> head({
    required final ApiConfig apiConfig,
  });

  Future<Uint8List> readBytes({
    required final ApiConfig apiConfig,
  });

  Future<http.StreamedResponse> send({required final http.BaseRequest request});
}

class HttpBaseRequest extends http.BaseRequest {
  HttpBaseRequest(super.method, super.url);
}

class HttpMultipartRequest extends http.MultipartRequest {
  HttpMultipartRequest(super.method, super.url);
}

class HttpMultipartFile {
  final String fieldName;
  final File file;

  HttpMultipartFile(this.fieldName, this.file);

  Future<http.MultipartFile> toMultipartFile() async =>
      http.MultipartFile.fromPath(
        fieldName,
        file.path,
      );
}
