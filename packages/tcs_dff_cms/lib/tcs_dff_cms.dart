library liferay_cms_plugin;

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:tcs_dff_types/plugin/cms_plugin.dart';

export 'package:tcs_dff_cms/tcs_dff_cms.dart';

class LiferayCMSPlugin extends CMSPlugin {
  final String dataset;
  final String projectId;
  final String token;
  final http.Client httpClient;

  LiferayCMSPlugin({
    required this.dataset,
    required this.projectId,
    required this.token,
    final http.Client? httpClient,
  }) : httpClient = httpClient ?? http.Client();

  @override
  Future<T?> fetchContent<T>(
    final String request,
    final JsonToModel<T> fromJson,
  ) async {
    final response = _fetch(request: request);

    return fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<List<T>> fetchContentList<T>(
    final String request,
    final JsonToModel<T> fromJson,
  ) async {
    await _fetch(request: request);

    return [];
  }

  @override
  String? fetchImage(
    final String url,
    final ImageConfig options,
  ) {
    final response = _fetch(request: url);

    return response as String;
  }

  @override
  Future<void> init() async {}

  @override
  Future<void> release() async {}

  Future<dynamic> _fetch({
    required final String request,
    final Map<String, dynamic>? params,
  }) async {
    final uri = _getUri(query: request, params: params);
    final response = await httpClient.get(uri, headers: _requestHeaders());

    return _getResponse(response);
  }

  Uri _getUri({
    required final String query,
    final Map<String, dynamic>? params,
  }) {
    final queryParameters = <String, dynamic>{
      'query': query,
      if (params != null) ...params,
    };

    return Uri(
      scheme: 'https',
      host: projectId,
      path: '',
      queryParameters: queryParameters,
    );
  }

  Map<String, String> _requestHeaders() => {'Authorization': 'Bearer $token'};

  dynamic _getResponse(final http.Response response) {
    switch (response.statusCode) {
      case 200:
        final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
        return responseJson['result'];

      default:
        throw Exception(
          '${response.statusCode}: ${response.body.toString()}',
        );
    }
  }
}
