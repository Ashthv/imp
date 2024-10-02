import 'package:flutter/material.dart';

import '../../tcs_dff_design_system.dart';
import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';

class BranchLocationWidget extends StatelessWidget {
  const BranchLocationWidget({
    super.key,
    this.imagePath,
    this.package,
    required this.title,
    required this.subTitle,
    this.isSelected = false,
  });

  final String? imagePath;
  final String? package;
  final String title;
  final String subTitle;
  final bool isSelected;

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.size12.dp,
        horizontal: size.size24,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? color.clrPrimaryPurple : color.greyLightGrey60,
          width: size.size1.dp,
        ),
        borderRadius: BorderRadius.circular(
          size.size6.dp,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textStyle.h316pxsemiBold.copyWith(
                    fontSize: size.size16.dp,
                    fontWeight: FontWeight.w600,
                    color: color.greyBlackUi10,
                  ),
                ),
                Text(
                  subTitle,
                  style: textStyle.h414pxRegular.copyWith(
                    fontSize: size.size14.dp,
                    fontWeight: FontWeight.w400,
                    color: color.greyDarkestGrey20,
                  ),
                ),
              ],
            ),
          ),
          if (imagePath != null)
            Expanded(
              child: ImageWidget(
                imageType: ImageType.assetImage,
                path: imagePath!,
                package: package,
              ),
            ),
        ],
      ),
    );
  }
}
