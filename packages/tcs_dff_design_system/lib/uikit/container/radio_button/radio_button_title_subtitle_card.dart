import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../foundation/radio_button.dart';

class RadioButtonTitleSubtitleCard extends StatelessWidget {
  const RadioButtonTitleSubtitleCard({
    super.key,
    required this.isSelected,
    required this.onChanged,
    required this.title,
    this.subTitle,
    this.titleTextStyle,
    this.subTitleTextStyle,
    this.isEnabled = true,
  });
  final Function(bool value) onChanged;
  final TextStyle? titleTextStyle;
  final TextStyle? subTitleTextStyle;
  final bool isSelected;
  final String title;
  final String? subTitle;
  final bool isEnabled;

  @override
  Widget build(final BuildContext context) {
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;
    final size = context.theme.appSize;

    return GestureDetector(
      onTap: () {
        if (isEnabled) {
          onChanged(isSelected);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
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
                size.size6.dp,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: subTitle != null ? size.size11.dp : size.size16.dp,
                horizontal: size.size12.dp,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioButton(
                    onChanged: onChanged,
                    isSelected: isSelected,
                    isEnabled: isEnabled,
                  ),
                  SizedBox(
                    width: size.size14,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: titleTextStyle ??
                                    textStyle.h316pxsemiBold.copyWith(
                                      color: isEnabled
                                          ? isSelected
                                              ? color.clrPrimaryPurple10
                                              : color.greyBlackUi10
                                          : color.greyBlackUi10
                                              .withOpacity(0.6),
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
                                  style: subTitleTextStyle ??
                                      textStyle.bodyCopy3Small14Regular
                                          .copyWith(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
