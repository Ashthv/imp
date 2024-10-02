import 'package:flutter/material.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class ProfileImage extends StatelessWidget {
  final String image;
  final String? package;
  final Color? borderColor;
  final double? width;
  final double? height;
  final String? placeholderImagePath;
  final ImageType imageType;

  const ProfileImage({
    super.key,
    required this.image,
    this.package,
    this.borderColor,
    this.width,
    this.height,
    this.placeholderImagePath,
    this.imageType = ImageType.assetImage,
  });

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    return Card(
      shape: CircleBorder(
        side: BorderSide(
          width: size.size1.dp,
          color: borderColor ?? color.clrPrimaryPurple50,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size.size120.dp),
        child: SizedBox(
          width: width ?? size.size50.dp,
          height: height ?? size.size50.dp,
          child: ImageWidget(
            imageType: imageType,
            path: image,
            placeholderImagePath: placeholderImagePath,
            package: package,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
