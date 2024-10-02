import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../foundation/text_widget.dart';
import 'card/card_config.dart';
import 'image/image_widget.dart';

class ProductDescriptionDetailsWidget extends StatelessWidget {
  final String productTitleText;
  final CardConfig cardModel;
  final String imagePath;
  final String? imagePackage;

  const ProductDescriptionDetailsWidget({
    super.key,
    required this.productTitleText,
    required this.cardModel,
    required this.imagePath,
    this.imagePackage,
  });

  @override
  Widget build(final BuildContext context) {
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;

    return SizedBox(
      child: Card(
        shape: cardModel.shapeBorder,
        margin: cardModel.margin,
        elevation: cardModel.elevation,
        child: Container(
          padding: EdgeInsets.all(
            context.theme.appSize.size12.dp,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              context.theme.appSize.size8.dp,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageWidget(
                imageType: ImageType.assetImage,
                path: imagePath,
                package: imagePackage,
              ),
              SizedBox(
                height: context.theme.appSize.size4.dp,
              ),
              TextWidget(
                text: productTitleText,
                style: textStyle.h414pxRegular.copyWith(
                  color: color.greyDarkGrey30,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
