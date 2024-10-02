import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../foundation/radio_button.dart';

class RadioButtonTitleSubtitle extends StatelessWidget {
  final String title;
  final Function(bool value) onChanged;
  final bool isEnabled;
  final bool isError;
  final bool isSelected;
  final String? subTitle;
  RadioButtonTitleSubtitle({
    required this.title,
    required this.onChanged,
    required this.isSelected,
    this.subTitle,
    this.isEnabled = true,
    this.isError = false,
  });

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;
    return Flexible(
      child: GestureDetector(
        onTap: () {
          onChanged(isSelected);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioButton(
              onChanged: onChanged,
              isSelected: isSelected,
            ),
            SizedBox(
              width: size.size10.dp,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: textStyle.bodyCopy2Small16Regular,
                  ),
                  if (subTitle != null)
                    Text(
                      subTitle!,
                      style: textStyle.bodyCopy3Small14Regular.copyWith(
                        color: color.greyDarkGrey30,
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
