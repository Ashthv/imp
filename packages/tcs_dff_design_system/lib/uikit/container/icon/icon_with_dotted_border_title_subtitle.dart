import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../image/image_widget.dart';
import 'dotted_border.dart';

class IconWithDottedBorderTitleSubtitle extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String imagePath;
  final String package;
  final double? dottedBorderHeight;
  final double? dottedBorderwidth;
  final TextStyle? subTitleStyle, titleStyle;

  IconWithDottedBorderTitleSubtitle({
    required this.title,
    this.subTitle,
    required this.imagePath,
    required this.package,
    this.dottedBorderHeight,
    this.dottedBorderwidth,
    this.titleStyle,
    this.subTitleStyle,
  });

  @override
  Widget build(final BuildContext context) {
    final textStyle = context.theme.appTextStyles;
    final size = context.theme.appSize;
    final color = context.theme.appColor;

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: dottedBorderwidth ?? size.size60.dp,
                height: dottedBorderHeight ?? size.size60.dp,
                child: CustomPaint(
                  painter: DottedBorder(
                    numberOfStories: size.size40.dp,
                    spaceLength: size.size2.dp,
                    context: context,
                  ),
                ),
              ),
              Container(
                child: ImageWidget(
                  imageType: ImageType.assetImage,
                  path: imagePath,
                  package: package,
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                right: size.size18.dp,
                left: size.size18.dp,
                top: (subTitle != null) ? size.size0.dp : size.size18.dp,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: titleStyle ??
                        textStyle.bodyCopy1Medium18Medium.copyWith(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: size.size18,
                          color: color.greyDarkGrey30,
                        ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: size.size4.dp),
                    child: Text(
                      subTitle ?? '',
                      style: subTitleStyle ??
                          textStyle.bodyCopy1Medium18Medium.copyWith(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: size.size14,
                            color: color.greyGrey50,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
