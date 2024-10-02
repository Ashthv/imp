import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../foundation/text_widget.dart';

import '../image/image_widget.dart';
import 'card_config.dart';

class ProductDescriptionBannerWidget extends StatelessWidget {
  final String bannerText;
  final String loanAmount;
  final CardConfig cardModel;
  final String imagePath;
  final String? imagePackage;
  final TextStyle? bannerTextStyle, loanAmountStyle;
  final Alignment? textAlign;

  const ProductDescriptionBannerWidget({
    super.key,
    required this.bannerText,
    required this.loanAmount,
    required this.cardModel,
    required this.imagePath,
    this.imagePackage,
    this.bannerTextStyle,
    this.loanAmountStyle,
    this.textAlign,
  });

  @override
  Widget build(final BuildContext context) {
    final textStyle = context.theme.appTextStyles;
    final size = Theme.of(context).appSize;
    final color = context.theme.appColor;

    return Card(
      shape: cardModel.shapeBorder,
      margin: cardModel.margin,
      elevation: cardModel.elevation,
      child: Stack(
        children: [
          ImageWidget(
            imageType: ImageType.assetImage,
            path: imagePath,
            package: imagePackage,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                size.size20.dp,
              ),
            ),
            child: Align(
              alignment: textAlign ?? Alignment.center,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.size8.dp,
                      left: size.size24.dp,
                    ),
                    child: TextWidget(
                      text: bannerText,
                      style: bannerTextStyle ??
                          textStyle.labelSmall16Medium.copyWith(
                            color: color.greyWhiteUi100,
                            fontWeight: FontWeight.w400,
                            fontSize: size.size16,
                            fontStyle: FontStyle.normal,
                          ),
                    ),
                  ),
                  TextWidget(
                    text: loanAmount,
                    style: loanAmountStyle ??
                        textStyle.labelSmall16Medium.copyWith(
                          color: color.greyWhiteUi100,
                          fontWeight: FontWeight.w600,
                          fontSize: size.size38,
                          fontStyle: FontStyle.normal,
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
