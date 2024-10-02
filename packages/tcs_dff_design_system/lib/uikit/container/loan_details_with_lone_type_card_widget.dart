import 'package:flutter/material.dart';

import '../../tcs_dff_design_system.dart';
import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';

class LoanDetailsWithloanTypeCardWidget extends StatelessWidget {
  const LoanDetailsWithloanTypeCardWidget({
    super.key,
    required this.cardModel,
    this.cardHeaderTitle,
    this.cardSubHeaderTitle,
    this.cardSubHeaderTitle1,
    this.cardSubHeaderTitleText,
    this.cardSubHeaderTitle1Text,
    this.titleStyle,
    this.subtitleStyle,
    this.headerTextStyle,
    this.imagePath,
    this.imagePackage,
    this.customPattern,
    required this.onpressed,
  });
  final CardConfig cardModel;
  final String? cardHeaderTitle,
      cardSubHeaderTitle,
      cardSubHeaderTitle1,
      cardSubHeaderTitleText,
      imagePath,
      imagePackage,
      customPattern,
      cardSubHeaderTitle1Text;
  final TextStyle? headerTextStyle, titleStyle, subtitleStyle;
  final VoidCallback onpressed;

  @override
  Widget build(final BuildContext context) {
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;
    final size = context.theme.appSize;

    return Card(
      shape: cardModel.shapeBorder,
      margin: cardModel.margin,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            context.theme.appSize.size8.dp,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: color.clrPrimaryPurple110,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size.size8.dp),
                  topRight: Radius.circular(size.size8.dp),
                ),
              ), //context.theme.appSize.size8.dp
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.size8.dp,
                  vertical: size.size16.dp,
                ),
                child: TextWidget(
                  text: cardHeaderTitle ?? '',
                  style: (headerTextStyle != null)
                      ? headerTextStyle
                      : textStyle.bodyCopy2Medium16SemiBold.copyWith(
                          color: color.clrPrimaryPurple20,
                        ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: color.greyFullWhite120,
                border: Border.all(
                  color: color.greyLightestGrey80,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(size.size8.dp),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.size8.dp,
                  vertical: size.size24.dp,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: cardSubHeaderTitle ?? '',
                          style: (titleStyle != null)
                              ? titleStyle
                              : textStyle.bodyCopy3Small14Regular.copyWith(
                                  color: color.greyDarkestGrey20,
                                ),
                        ),
                        SizedBox(
                          height: size.size5.dp,
                        ),
                        TextWidgetMasking(
                          customPattern: customPattern ?? '',
                          text: cardSubHeaderTitleText ?? '',
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: cardSubHeaderTitle1 ?? '',
                          style: (titleStyle != null)
                              ? titleStyle
                              : textStyle.bodyCopy3Small14Regular.copyWith(
                                  color: color.greyDarkestGrey20,
                                ),
                        ),
                        TextWidget(
                          text: cardSubHeaderTitle1Text ?? '',
                          style: (subtitleStyle != null)
                              ? subtitleStyle
                              : textStyle.labelSmall16Medium.copyWith(
                                  color: color.greyBlackUi10,
                                ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: size.size36.dp,
                      height: size.size36.dp,
                      child: InkWell(
                        onTap: onpressed,
                        child: ImageWidget(
                          imageType: ImageType.assetImage,
                          path: imagePath ?? '',
                          package: imagePackage,
                          color: color.clrPrimaryPurple,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
