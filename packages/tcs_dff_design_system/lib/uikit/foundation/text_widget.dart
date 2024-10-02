import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final List<String>? styledTextList;
  final TextStyle? style;
  final TextStyle? styledTextStyle;
  final int maxLine;
  final Widget? widget;
  final TextAlign textAlign;

  const TextWidget({
    super.key,
    required this.text,
    this.style,
    this.styledTextList,
    this.styledTextStyle,
    this.maxLine = 1,
    this.widget,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(final BuildContext context) => RichText(
        textAlign: textAlign,
        text: getStyledText(context, text, styledTextList ?? []),
      );

  TextSpan getStyledText(
    final BuildContext context,
    final String text,
    final List<String> styledTextList,
  ) {
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    final size = context.theme.appSize;
    final textSpans = <InlineSpan>[];
    final splitTextList =
        splitTextUsingStyledTextList(context, text, styledTextList);

    for (final splitText in splitTextList) {
      if (styledTextList.contains(splitText)) {
        textSpans.add(
          TextSpan(
            text: splitText,
            style: styledTextStyle ??
                textStyle.h316pxsemiBold.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color.clrPrimaryPurple,
                  fontStyle: FontStyle.normal,
                  fontSize: size.size16.dp,
                ),
          ),
        );
      } else {
        textSpans.add(
          TextSpan(
            text: splitText,
            style: style ??
                textStyle.h316pxsemiBold.copyWith(
                  fontWeight: FontWeight.w400,
                  color: color.greyBlackUi10,
                  fontStyle: FontStyle.normal,
                  fontSize: size.size16.dp,
                ),
          ),
        );
      }
    }

    if (widget != null) {
      textSpans.add(
        WidgetSpan(
          child: widget!,
          alignment: PlaceholderAlignment.middle,
        ),
      );
    }

    return TextSpan(
      children: textSpans,
    );
  }

  List<String> splitTextUsingStyledTextList(
    final BuildContext context,
    final String text,
    final List<String> styledTextList,
  ) {
    final splitTextList = <String>[];
    var currentIndex = 0;

    for (final styledText in styledTextList) {
      final index = text.indexOf(styledText, currentIndex);

      if (index != -1) {
        splitTextList
          ..add(text.substring(currentIndex, index))
          ..add(styledText);
        currentIndex = index + styledText.length;
      }
    }

    if (currentIndex < text.length) {
      splitTextList.add(text.substring(currentIndex));
    }

    return splitTextList;
  }
}
