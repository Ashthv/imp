import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../image/image_widget.dart';

class CardWithImageAndTitle extends StatelessWidget {
  final String iconText;
  final VoidCallback callback;
  final String imagePath;
  final String imagePackage;
  final TextStyle? textFontStyle;

  CardWithImageAndTitle({
    super.key,
    required this.iconText,
    required this.callback,
    required this.imagePath,
    required this.imagePackage,
    this.textFontStyle,
  });

  @override
  Widget build(final BuildContext context) {
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;
    final size = context.theme.appSize;

    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        color: context.theme.appColor.clrPrimaryBlue90,
        padding: EdgeInsets.only(
          top: context.theme.appSize.size20,
          bottom: context.theme.appSize.size20,
        ),
        child: InkWell(
          onTap: callback,
          child: Column(
            children: [
              Container(
                height: context.theme.appSize.size70,
                width: context.theme.appSize.size70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.size12.dp),
                ),
                child: Card(
                  margin: EdgeInsets.all(context.theme.appSize.size5),
                  elevation: context.theme.appSize.size5,
                  color: context.theme.appColor.greyWhiteUi100,
                  child: ImageWidget(
                    imageType: ImageType.assetImage,
                    path: imagePath,
                    package: imagePackage,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: context.theme.appSize.size5),
                child: Text(
                  iconText,
                  style: (textFontStyle != null)
                      ? textFontStyle
                      : textStyle.labelSmall14Medium.copyWith(
                          color: color.clrPrimaryPurple10,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
