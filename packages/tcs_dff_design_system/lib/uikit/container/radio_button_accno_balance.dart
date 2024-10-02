import 'package:flutter/material.dart';
import 'package:tcs_dff_shared_library/masker/masker.dart';

import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';
import '../foundation/radio_button.dart';
import '../foundation/text_widget.dart';

class RadioButtonAccnoBalance extends StatelessWidget {
  const RadioButtonAccnoBalance({
    super.key,
    required this.onChanged,
    required this.isRadioButtonSelected,
    required this.accountTypeTitle,
    required this.amountTitle,
    required this.accountNumber,
    required this.availableAmount,
    this.titleStyle,
    this.subTitleStyle,
  });

  final Function(bool) onChanged;
  final bool isRadioButtonSelected;
  final String accountTypeTitle, amountTitle, accountNumber, availableAmount;
  final TextStyle? titleStyle, subTitleStyle;

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;

    return Container(
      margin: EdgeInsetsDirectional.symmetric(
        horizontal: size.size21.dp,
        vertical: size.size5.dp,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          context.theme.appSize.size6.dp,
        ),
        border: Border.all(
          color: isRadioButtonSelected
              ? color.clrPrimaryPurple20
              : color.greyLightGrey60,
          width: size.size1.dp,
        ),
        color: isRadioButtonSelected
            ? color.clrPrimaryPurple20.withOpacity(0.05)
            : color.greyWhiteUi100,
      ),
      child: Padding(
        padding: EdgeInsets.all(size.size16.dp),
        child: Row(
          children: [
            RadioButton(
              onChanged: onChanged,
              isSelected: isRadioButtonSelected,
            ),
            SizedBox(
              width: size.size16.dp,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: accountTypeTitle,
                  style: (titleStyle != null)
                      ? titleStyle
                      : textStyle.h414pxRegular
                          .copyWith(color: color.greyBlackUi10),
                ),
                TextWidget(
                  text: Masker.doMask(
                    originalText: accountNumber,
                    maskType: MaskTypes.custom,
                    customPattern: 'XXXXXXX####',
                  ),
                  style: (subTitleStyle != null)
                      ? subTitleStyle
                      : textStyle.h316pxsemiBold
                          .copyWith(color: color.greyDarkestGrey20),
                ),
              ],
            ),
            SizedBox(
              width: size.size16.dp,
            ),
            Container(
              width: 1,
              height: size.size40.dp,
              color: color.greyLightestGrey80,
            ),
            SizedBox(
              width: size.size16.dp,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: amountTitle,
                  style: (titleStyle != null)
                      ? titleStyle
                      : textStyle.h414pxRegular
                          .copyWith(color: color.greyBlackUi10),
                ),
                TextWidget(
                  text: availableAmount,
                  style: (subTitleStyle != null)
                      ? subTitleStyle
                      : textStyle.h316pxsemiBold
                          .copyWith(color: color.greyDarkestGrey20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
