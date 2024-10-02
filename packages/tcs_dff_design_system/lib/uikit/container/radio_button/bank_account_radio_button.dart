import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../foundation/radio_button.dart';
import '../../foundation/text_widget.dart';
import '../image/image_widget.dart';

class BankAccountRadioButton extends StatelessWidget {
  final Function(bool value) onChanged;
  final bool isSelected;
  final String title;
  final TextStyle? titleTextStyle;
  final String? subTitle;
  final Widget? hyperLinkBtn;
  final bool isEnabled;
  final String? package;
  final String? leadingImagePath;

  const BankAccountRadioButton({
    super.key,
    required this.isSelected,
    required this.onChanged,
    required this.title,
    this.titleTextStyle,
    this.subTitle,
    this.hyperLinkBtn,
    this.isEnabled = true,
    this.package,
    this.leadingImagePath,
  });

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;

    return GestureDetector(
      onTap: () {
        if (isEnabled == false) {
          onChanged(isSelected);
        }
      },
      child: Card(
        color: isEnabled
            ? isSelected
                ? color.clrPrimaryPurple120
                : color.greyWhiteUi100
            : color.greyWhiteUi100.withOpacity(0.9),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isEnabled
                ? isSelected
                    ? color.clrPrimaryPurple80
                    : color.greyLightestGrey80
                : color.greyLightestGrey80.withOpacity(0.9),
            width: size.size1.dp,
          ),
          borderRadius: BorderRadius.circular(
            size.size8.dp,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: size.size11.dp,
            bottom: size.size12.dp,
            left: size.size12.dp,
            right: size.size12.dp,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingImagePath != null)
                ImageWidget(
                  imageType: ImageType.assetImage,
                  path: leadingImagePath!,
                  package: package,
                ),
              SizedBox(
                width: size.size8,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextWidget(
                            text: title,
                            style: titleTextStyle ??
                                textStyle.h316pxsemiBold.copyWith(
                                  color: isEnabled
                                      ? isSelected
                                          ? color.clrPrimaryPurple10
                                          : color.greyBlackUi10
                                      : color.greyBlackUi10.withOpacity(0.6),
                                ),
                          ),
                        ),
                      ],
                    ),
                    if (subTitle != null)
                      Row(
                        children: [
                          Expanded(
                            child: TextWidget(
                              text: subTitle!,
                              widget: hyperLinkBtn,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              RadioButton(
                onChanged: onChanged,
                isSelected: isSelected,
                isEnabled: isEnabled,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
