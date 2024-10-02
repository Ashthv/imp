import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../foundation/radio_button.dart';
import '../image/image_widget.dart';

class RadioButtonIconTitleSubtitleCard extends StatelessWidget {
  final Function(bool value) onChanged;
  final bool isSelected;
  final String title;
  final String? subTitle;
  final bool isEnabled;
  final String? package;
  final String? leadingImagePath;

  const RadioButtonIconTitleSubtitleCard({
    super.key,
    required this.isSelected,
    required this.onChanged,
    required this.title,
    this.subTitle,
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
                    : color.greyLighterGrey70
                : color.greyLighterGrey70.withOpacity(0.9),
            width: size.size1.dp,
          ),
          borderRadius: BorderRadius.circular(
            size.size8.dp,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.size11.dp,
            horizontal: size.size12.dp,
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
                width: size.size12,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: textStyle.h316pxsemiBold.copyWith(
                              color: isEnabled
                                  ? isSelected
                                      ? color.clrPrimaryPurple10
                                      : color.greyBlackUi10
                                  : color.greyBlackUi10.withOpacity(0.6),
                            ),
                            maxLines: size.size2.toInt(),
                          ),
                        ),
                      ],
                    ),
                    if (subTitle != null)
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              subTitle!,
                              style: textStyle.bodyCopy3Small14Regular.copyWith(
                                color: isEnabled
                                    ? color.greyMediumGrey40
                                    : color.greyDarkestGrey20,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: size.size2.toInt(),
                              overflow: TextOverflow.ellipsis,
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
