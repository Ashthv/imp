import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../image/image_widget.dart';
import 'card_config.dart';
import 'card_widget.dart';

class VerificationOptionCard extends StatelessWidget {
  VerificationOptionCard({
    super.key,
    required this.title,
    this.subTitle,
    this.imagePath,
    this.isEnabled = true,
    this.isSelected = false,
    this.imagePackage,
    required this.onTap,
  });

  final String title;
  final String? subTitle;
  final String? imagePath;
  final bool isEnabled;
  final bool isSelected;
  final String? imagePackage;
  final Function() onTap;

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    return InkWell(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CardWidget(
            childWidget: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: subTitle == null
                            ? EdgeInsets.symmetric(
                                vertical: size.size18.dp,
                              )
                            : EdgeInsets.symmetric(
                                vertical: size.size0.dp,
                              ),
                        child: Text(
                          title,
                          style: isEnabled
                              ? isSelected
                                  ? textStyle.bodyCopy1Medium18Medium.copyWith(
                                      color: color.greyWhiteUi100,
                                      fontWeight: FontWeight.w700,
                                    )
                                  : textStyle.bodyCopy1Medium18Medium.copyWith(
                                      color: color.greyDarkGrey30,
                                      fontWeight: FontWeight.w700,
                                    )
                              : textStyle.bodyCopy1Medium18Medium.copyWith(
                                  color: color.greyDarkGrey30,
                                  fontWeight: FontWeight.w700,
                                ),
                        ),
                      ),
                      if (subTitle != null)
                        Text(
                          subTitle!,
                          style: isEnabled
                              ? isSelected
                                  ? textStyle.h414pxRegular.copyWith(
                                      color: color.clrPrimaryPurple100,
                                      fontWeight: FontWeight.w400,
                                      height: size.size15.dp / size.size10.dp,
                                    )
                                  : textStyle.h414pxRegular.copyWith(
                                      color: color.greyDarkGrey30,
                                      fontWeight: FontWeight.w400,
                                      height: size.size15.dp / size.size10.dp,
                                    )
                              : textStyle.h414pxRegular.copyWith(
                                  color: color.greyDarkGrey30,
                                  fontWeight: FontWeight.w400,
                                  height: size.size15.dp / size.size10.dp,
                                ),
                        ),
                    ],
                  ),
                ),
                const Expanded(flex: 5, child: SizedBox()),
              ],
            ),
            cardModel: CardConfig(
              backgroundColor: isEnabled
                  ? isSelected
                      ? color.clrPrimaryPurple
                      : color.greyFullWhite120
                  : color.greyLightestGrey80,
              shapeBorder: RoundedRectangleBorder(
                side: BorderSide(
                  color: color.greyDarkGrey30,
                  width: size.size1.dp,
                ),
                borderRadius: BorderRadius.circular(
                  context.theme.appSize.size12,
                ),
              ),
            ),
          ),
          if (imagePath != null)
            Positioned(
              top: size.size17.dp,
              right: -size.size15.dp,
              bottom: -size.size15.dp,
              child: Container(
                child: ImageWidget(
                  imageType: ImageType.assetImage,
                  path: imagePath!,
                  package: imagePackage,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
