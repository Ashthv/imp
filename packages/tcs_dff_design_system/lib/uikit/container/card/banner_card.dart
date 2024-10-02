import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../foundation/text_widget.dart';
import '../image/image_widget.dart';
import 'card_config.dart';

class BannerCardWidget extends StatelessWidget {
  final String bannerText;
  final String buttonText;
  final String broderColorText;
  final List<String>? highlightedTexts;
  final CardConfig cardModel;
  final VoidCallback callback;
  final List<String> imagePath;
  final String? imagePackage;

  const BannerCardWidget({
    super.key,
    required this.bannerText,
    required this.buttonText,
    required this.broderColorText,
    this.highlightedTexts,
    required this.cardModel,
    required this.callback,
    required this.imagePath,
    this.imagePackage,
  });

  @override
  Widget build(final BuildContext context) {
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;
    final size = context.theme.appSize;

    return Card(
      shape: cardModel.shapeBorder,
      margin: cardModel.margin,
      elevation: cardModel.elevation,
      child: Stack(
        children: [
          ImageWidget(
            imageType: ImageType.assetImage,
            path: imagePath[0],
            package: imagePackage,
          ),
          Container(
            padding: EdgeInsets.only(
              top: context.theme.appSize.size10.dp,
              right: context.theme.appSize.size20.dp,
              left: context.theme.appSize.size20.dp,
              bottom: context.theme.appSize.size10.dp,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                context.theme.appSize.size20.dp,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: bannerText,
                        styledTextList: highlightedTexts ?? [],
                        style: textStyle.h414pxRegular.copyWith(
                          fontSize: size.size14.dp,
                          fontWeight: FontWeight.w400,
                          color: color.greyWhiteUi100,
                        ),
                        styledTextStyle: textStyle.h124pxsemiBold.copyWith(
                          fontSize: size.size24.dp,
                          fontWeight: FontWeight.w600,
                          color: color.greyWhiteUi100,
                        ),
                      ),
                      SizedBox(
                        height: context.theme.appSize.size10.dp,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: context.theme.appSize.size8.dp,
                          right: context.theme.appSize.size8.dp,
                          top: context.theme.appSize.size4.dp,
                          bottom: context.theme.appSize.size4.dp,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            context.theme.appSize.size8.dp,
                          ),
                          color: color.greyWhiteUi100.withOpacity(.25),
                        ),
                        child: TextWidget(
                          text: broderColorText,
                          style: textStyle.detailsSmall12Regular.copyWith(
                            fontSize: size.size12.dp,
                            fontWeight: FontWeight.w400,
                            color: color.greyWhiteUi100,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: context.theme.appSize.size10.dp,
                      ),
                      Container(
                        child: InkWell(
                          onTap: callback,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextWidget(
                                text: buttonText,
                                style: textStyle.h124pxsemiBold.copyWith(
                                  fontSize: size.size16.dp,
                                  fontWeight: FontWeight.w600,
                                  color: color.greyWhiteUi100,
                                ),
                                styledTextStyle: textStyle.h124pxsemiBold,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: context.theme.appSize.size4.dp,
                                ),
                                child: ImageWidget(
                                  imageType: ImageType.assetImage,
                                  path: imagePath[1],
                                  package: imagePackage,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
