import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../foundation/checkbox_widget.dart';

class CheckboxTitleSubtitle extends StatelessWidget {
  final String title;
  final Function(bool value) onChanged;
  final bool isError;
  final bool isChecked;
  final bool isMixed;
  final bool disabled;
  final String? subTitle;
  CheckboxTitleSubtitle({
    required this.title,
    required this.onChanged,
    this.isChecked = false,
    this.subTitle,
    this.isMixed = false,
    this.disabled = false,
    this.isError = false,
  });

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxWidget(
              onChanged: onChanged,
              isMixed: isMixed,
              isChecked: isChecked,
              disabled: disabled,
            ),
            SizedBox(
              width: size.size12.dp,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: disabled
                        ? textStyle.bodyCopy2Medium16SemiBold
                            .copyWith(color: color.greyGrey50)
                        : textStyle.bodyCopy2Medium16SemiBold,
                  ),
                  SizedBox(
                    height: size.size4.dp,
                  ),
                  if (subTitle != null)
                    Text(
                      subTitle!,
                      style: textStyle.bodyCopy3Small14Regular.copyWith(
                        color: disabled
                            ? color.greyLightGrey60
                            : color.greyDarkestGrey20,
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
