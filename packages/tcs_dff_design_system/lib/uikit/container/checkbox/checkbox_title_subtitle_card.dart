import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import 'checkbox_title_subtitle.dart';

class CheckboxTitleSubtitleCard extends StatelessWidget {
  final String title;
  final Function(bool value) onChanged;
  final bool isChecked;
  final String? subTitle;
  final bool isMixed;
  final bool disabled;
  CheckboxTitleSubtitleCard({
    required this.title,
    required this.onChanged,
    this.isMixed = false,
    this.isChecked = false,
    this.disabled = false,
    this.subTitle,
  });

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    return GestureDetector(
      onTap: disabled || isMixed
          ? null
          : () {
              onChanged(isChecked);
            },
      child: Card(
        color: disabled
            ? color.greyWhiteUi100
            : isChecked
                ? color.clrPrimaryPurple120
                : color.greyWhiteUi100,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isChecked ? color.clrPrimaryPurple70 : color.greyLightGrey60,
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
          child: CheckboxTitleSubtitle(
            title: title,
            onChanged: onChanged,
            isChecked: isChecked,
            subTitle: subTitle,
            isMixed: isMixed,
            disabled: disabled,
          ),
        ),
      ),
    );
  }
}
