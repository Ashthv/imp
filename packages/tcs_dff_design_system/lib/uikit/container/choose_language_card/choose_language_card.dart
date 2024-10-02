import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class ChooseLanguageCard extends StatelessWidget {
  const ChooseLanguageCard({
    super.key,
    required this.language,
    required this.localeText,
    required this.isSelected,
    required this.onChanged,
  });
  final String language;
  final String localeText;
  final bool isSelected;
  final Function(bool value) onChanged;

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;

    return GestureDetector(
      onTap: () => onChanged(isSelected),
      child: Column(
       mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: color.transparent,
              border: Border.all(
                color: color.clrPrimaryPurple60,
                width: 2.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? color.clrPrimaryPurple20
                      : color.clrPrimaryPurple100 ,
                  offset: Offset(size.size5.dp, size.size5.dp),
                ),
              ],
              borderRadius: BorderRadius.circular(size.size16.dp),
            ),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.size16.dp),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.fromLTRB(
                      size.size15.dp,
                      size.size10.dp,
                      size.size0.dp,
                      size.size0.dp,
                    ),
                    child: Text(
                      language,
                      style: textStyle.h414pxRegular.copyWith(
                        fontWeight: FontWeight.w400,
                        color: isSelected
                            ? color.greyWhiteUi100
                            : color.clrPrimaryPurple,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.fromLTRB(
                      size.size0.dp,
                      size.size0.dp,
                      size.size5.dp,
                      size.size5.dp,
                    ),
                    child: Text(
                      localeText,
                      textAlign: TextAlign.end,
                      style: textStyle.h520pxMedium.copyWith(
                        fontSize: size.size26.sp,
                        color: color.clrPrimaryPurple70,
                      ),
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
