import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../image/image_widget.dart';

class IconTitleSubtitleIcon extends StatelessWidget {
  IconTitleSubtitleIcon({
    super.key,
    required this.title,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.leftImagePath,
    this.rightImagePath,
    this.isIllusioned = false,
    this.package,
    this.imageType = ImageType.assetImage,
  });

  final String title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final String? leftImagePath;
  final String? rightImagePath;
  final bool isIllusioned;
  final String? package;
  final ImageType imageType;

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;

    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(
            right: size.size10.dp,
          ),
          padding: isIllusioned
              ? leftImagePath != null
                  ? EdgeInsets.all(size.size10.dp)
                  : EdgeInsets.all(size.size22.dp)
              : null,
          decoration: isIllusioned
              ? BoxDecoration(
                  border: Border.all(
                    color: color.greyLighterGrey70,
                    width: size.size5.dp / size.size10.dp,
                  ),
                  borderRadius: BorderRadius.circular(
                    size.size28.dp,
                  ),
                )
              : null,
          child: getLeftIconImage(),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: titleStyle ??
                    textStyle.bodyCopy2Medium16SemiBold.copyWith(
                      fontWeight: FontWeight.w400,
                      color: color.greyBlackUi10,
                    ),
              ),
              if (subtitle != null)
                Container(
                  margin: EdgeInsets.only(
                    top: size.size4.dp,
                    right: size.size10.dp,
                  ),
                  child: Text(
                    subtitle!,
                    style: subtitleStyle ??
                        textStyle.h414pxRegular.copyWith(
                          fontWeight: FontWeight.w400,
                          color: color.greyDarkGrey30,
                        ),
                    textAlign: TextAlign.left,
                  ),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        ),
        if (rightImagePath != null)
          getRightIconImage()
        else
          const SizedBox.shrink(),
      ],
    );
  }

  Widget getLeftIconImage() => leftImagePath != null
      ? Container(
          child: ImageWidget(
            imageType: imageType,
            path: leftImagePath!,
            package: package,
          ),
        )
      : const SizedBox.shrink();

  Widget getRightIconImage() => rightImagePath != null
      ? Container(
          child: ImageWidget(
            imageType: imageType,
            path: rightImagePath!,
            package: package,
          ),
        )
      : const SizedBox.shrink();
}
