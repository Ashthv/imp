import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../image/image_widget.dart';

class OverlappingCardImage extends StatelessWidget {
  const OverlappingCardImage({
    super.key,
    required this.imagePath,
    required this.package,
    required this.imagePadding,
    this.boxFit,
  });

  final String imagePath;
  final String package;
  final EdgeInsets imagePadding;
  final BoxFit? boxFit;

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: size.size8.dp,
          top: size.size12.dp,
          child: Card(
            color: color.clrPrimaryPurple40,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(size.size12.dp),
              ),
            ),
            child: SizedBox(
              width: size.size70.dp,
              height: size.size96.dp,
            ),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                size.size12.dp,
              ),
            ),
          ),
          child: SizedBox(
            width: size.size70.dp,
            height: size.size96.dp,
            child: FittedBox(
              fit: boxFit ?? BoxFit.cover,
              child: Container(
                padding: imagePadding,
                child: ImageWidget(
                  imageType: ImageType.assetImage,
                  path: imagePath,
                  package: package,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
