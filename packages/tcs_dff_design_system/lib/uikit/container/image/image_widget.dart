import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/image_type.dart';

class ImageWidget extends StatelessWidget {
  ImageWidget({
    required this.imageType,
    required this.path,
    this.package,
    this.fit = BoxFit.none,
    this.placeholderImagePath,
    this.color,
    super.key,
  });

  final ImageType imageType;
  final String path;
  final BoxFit fit;
  final String? package;
  final String? placeholderImagePath;
  final Color? color;

  @override
  Widget build(final BuildContext context) => Container(
        child: imageType == ImageType.assetImage
            ? buildImageWidget(path)
            : buildNetworkImage(),
      );

  Widget buildImageWidget(final String path) => _checkIfImageTypeSvg()
      ? color != null
          ? SvgPicture.asset(
              package: package,
              path,
              fit: fit,
              colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
            )
          : SvgPicture.asset(
              package: package,
              path,
              fit: fit,
            )
      : Image.asset(
          fit: fit,
          path,
          package: package,
        );

  bool _checkIfImageTypeSvg() => path.split('.')[1] == 'svg';

  bool _checkIfINetworkImageTypeSvg() {
    final paths = path.split('_');
    return paths.length == 2 && paths[1] == 'svg';
  }

  Widget buildNetworkImage() {
    if (_checkIfINetworkImageTypeSvg()) {
      return SvgPicture.network(
        path,
        fit: fit,
        placeholderBuilder: (final context) {
          if (placeholderImagePath != null) {
            return buildImageWidget(placeholderImagePath!);
          } else {
            return const SizedBox.shrink();
          }
        },
      );
    } else {
      return CachedNetworkImage(
        imageUrl: path,
        fit: fit,
        placeholder: (final context, final url) {
          if (placeholderImagePath != null) {
            return buildImageWidget(placeholderImagePath!);
          } else {
            return const SizedBox.shrink();
          }
        },
      );
    }
  }
}
