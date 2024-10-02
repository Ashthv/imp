import 'plugin_types.dart';

typedef JsonToModel<T> = T Function(Map<String, dynamic> json);

class ImageConfig {
  final int? width;
  final int? height;
  final int? quality;

  ImageConfig({
    this.width,
    this.height,
    this.quality,
  });
}

abstract class CMSPlugin implements Plugin {
  Future<T?> fetchContent<T>(
    final String request,
    final JsonToModel<T> fromJson,
  );

  Future<List<T?>> fetchContentList<T>(
    final String request,
    final JsonToModel<T> fromJson,
  );

  String? fetchImage(final String url, final ImageConfig options);
}
