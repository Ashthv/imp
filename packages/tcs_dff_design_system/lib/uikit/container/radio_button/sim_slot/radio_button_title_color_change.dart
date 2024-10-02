import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/sizer/app_sizer.dart';
import '../../../foundation/radio_button.dart';

class RadioButtonTitleColorChange extends StatelessWidget {
  final String title;
  final Function(bool value) onChanged;
  final bool isEnabled;
  final bool isError;
  final bool isSelected;

  RadioButtonTitleColorChange({
    required this.title,
    required this.onChanged,
    required this.isSelected,
    this.isEnabled = true,
    this.isError = false,
  });

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;
    return GestureDetector(
      onTap: () {
        onChanged(isSelected);
      },
      child: Row(
        children: [
          RadioButton(
            onChanged: onChanged,
            isSelected: isSelected,
            isError: isError,
            isEnabled: isEnabled,
          ),
          SizedBox(
            width: size.size8.dp,
          ),
          Text(
            title,
            style: textStyle.h316pxsemiBold.copyWith(
              color: isError
                  ? color.statRedDefault
                  : isEnabled
                      ? isSelected
                          ? color.clrPrimaryPurple
                          : color.greyGrey50
                      : color.greyGrey50,
              fontSize: size.size16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
