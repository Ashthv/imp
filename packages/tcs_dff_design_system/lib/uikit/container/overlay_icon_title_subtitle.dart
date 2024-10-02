import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../../utils/image_type.dart';
import '../../utils/sizer/app_sizer.dart';
import '../foundation/text_widget.dart';
import 'image/image_widget.dart';

class OverlayIconTitleSubtitle extends StatelessWidget {
  final String imagePath;
  final String title;
  final String? subTitle;
  final String imagePackage;
  final Function() onTapped;

  OverlayIconTitleSubtitle({
    super.key,
    required this.imagePath,
    required this.title,
    this.subTitle = '',
    this.imagePackage = '',
    required this.onTapped,
  });

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    return InkWell(
      onTap: onTapped,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: color.clrPrimaryPink100,
                  offset: Offset(size.size15.dp, size.size15.dp),
                ),
              ],
              borderRadius: BorderRadius.circular(size.size15.dp),
            ),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.size15.dp),
              ),
              child: ImageWidget(
                fit: BoxFit.fill,
                imageType: ImageType.assetImage,
                path: imagePath,
                package: imagePackage,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.size27.dp),
            child: TextWidget(
              text: title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: size.size14.sp,
                color: color.clrPrimaryPurple100,
              ),
            ),
          ),
          TextWidget(
            text: subTitle!,
            maxLine: 3,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: size.size14.sp,
              color: color.greyBlackUi10,
            ),
          ),
        ],
      ),
    );
  }
}
