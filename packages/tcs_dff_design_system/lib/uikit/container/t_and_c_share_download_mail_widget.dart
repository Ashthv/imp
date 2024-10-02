import 'package:flutter/material.dart';

import '../../tcs_dff_design_system.dart';
import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';

class TAndCShareDownloadMailWidget extends StatelessWidget {
  const TAndCShareDownloadMailWidget({
    super.key,
    required this.cardModel,
    required this.imagePackage,
    this.fileimagePath,
    this.infoImagePath,
    required this.title,
    required this.subTitle,
    required this.infoButtonAction,
    this.viewImagePath,
    this.downloadIcon,
    this.emailIcon,
    this.viewButtonAction,
    this.downloadButtonAction,
    this.emailButtonAction,
    this.titleTextStyle,
    this.subTitleTextStyle,
  });

  final CardConfig cardModel;
  final String imagePackage;
  final String? fileimagePath,
      infoImagePath,
      viewImagePath,
      downloadIcon,
      emailIcon;
  final String title, subTitle;
  final Function() infoButtonAction;
  final Function()? viewButtonAction;
  final Function()? downloadButtonAction;
  final Function()? emailButtonAction;
  final TextStyle? titleTextStyle, subTitleTextStyle;

  @override
  Widget build(final BuildContext context) {
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;
    final size = context.theme.appSize;

    return Card(
      shape: cardModel.shapeBorder,
      margin: cardModel.margin,
      elevation: cardModel.elevation,
      child: Container(
        width:
            (viewImagePath == null && downloadIcon == null && emailIcon == null)
                ? MediaQuery.of(context).size.width * 0.5
                : MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          horizontal: context.theme.appSize.size8.dp,
          vertical: context.theme.appSize.size8.dp,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            context.theme.appSize.size8.dp,
          ),
          border: Border.all(
            color: color.clrPrimaryBlue20,
            width: size.size1.dp,
          ),
        ),
        child: Row(
          children: [
            Visibility(
              visible: fileimagePath?.isNotEmpty ?? false,
              child: SizedBox(
                width: size.size32.dp,
                height: size.size32.dp,
                child: ImageWidget(
                  imageType: ImageType.assetImage,
                  path: fileimagePath ?? '',
                  package: imagePackage,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: title,
                    style: (titleTextStyle != null)
                        ? titleTextStyle
                        : textStyle.h414pxRegular.copyWith(
                            color: color.greyBlackUi10,
                          ),
                  ),
                  Row(
                    children: [
                      TextWidget(
                        text: subTitle,
                        style: (subTitleTextStyle != null)
                            ? subTitleTextStyle
                            : textStyle.detailsSmall12Regular.copyWith(
                                color: color.greyDarkGrey30,
                              ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      IconButton(
                        icon: ImageWidget(
                          imageType: ImageType.assetImage,
                          path: infoImagePath ?? '',
                          package: imagePackage,
                        ),
                        onPressed: infoButtonAction,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Visibility(
                  visible: viewImagePath?.isNotEmpty ?? false,
                  child: IconButton(
                    onPressed: viewButtonAction,
                    icon: ImageWidget(
                      imageType: ImageType.assetImage,
                      path: viewImagePath ?? '',
                      package: imagePackage,
                    ),
                  ),
                ),
                Visibility(
                  visible: downloadIcon?.isNotEmpty ?? false,
                  child: IconButton(
                    onPressed: downloadButtonAction,
                    icon: ImageWidget(
                      imageType: ImageType.assetImage,
                      path: downloadIcon ?? '',
                      package: imagePackage,
                    ),
                  ),
                ),
                Visibility(
                  visible: emailIcon?.isNotEmpty ?? false,
                  child: IconButton(
                    onPressed: emailButtonAction,
                    icon: ImageWidget(
                      imageType: ImageType.assetImage,
                      path: emailIcon ?? '',
                      package: imagePackage,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
