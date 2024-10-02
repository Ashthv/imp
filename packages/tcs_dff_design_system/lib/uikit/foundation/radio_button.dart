import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';

class RadioButton extends StatelessWidget {
  final Function(bool) onChanged;
  final bool isEnabled;
  final bool isError;
  final bool isSelected;

  RadioButton({
    required this.onChanged,
    required this.isSelected,
    this.isEnabled = true,
    this.isError = false,
  });

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;

    return Container(
      child: GestureDetector(
        onTap: () {
          if (isEnabled) {
            onChanged(isSelected);
          }
        },
        child: Container(
          height: size.size20.dp,
          width: size.size20.dp,
          decoration: ShapeDecoration(
            shape: const CircleBorder(),
            color: isError
                ? color.statRedDefault
                : isEnabled
                    ? isSelected
                        ? color.clrPrimaryPurple
                        : color.greyGrey50
                    : color.greyLightestGrey80,
          ),
          child: Center(
            child: Container(
              height: size.size18.dp,
              width: size.size18.dp,
              decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: color.greyWhiteUi100,
              ),
              child: Visibility(
                visible: !isError,
                child: Center(
                  child: Container(
                    height: size.size12.dp,
                    width: size.size12.dp,
                    decoration: ShapeDecoration(
                      shape: const CircleBorder(),
                      color: isEnabled
                          ? isSelected
                              ? color.clrPrimaryPurple
                              : color.transparent
                          : color.greyWhiteUi100,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
