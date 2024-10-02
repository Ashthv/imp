import 'dart:math';

import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class InitialsCircle extends StatelessWidget {
  final String title;

  const InitialsCircle({
    super.key,
    required this.title,
  });

  @override
  Widget build(final BuildContext context) {
    final color = getRandomColor(context);
    return Container(
      width: context.theme.appSize.size46.dp,
      height: context.theme.appSize.size46.dp,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(context.theme.appSize.size1.dp),
        child: Container(
          decoration: BoxDecoration(
            color: context.theme.appColor.greyWhiteUi100,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(context.theme.appSize.size2.dp),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.3),
              ),
              child: Text(
                initialLetters(title),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.theme.appSize.size16.dp,
                  color: color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color getRandomColor(final BuildContext context) {
    final predefinedColors = [
      context.theme.appColor.clrPrimaryPurple,
      context.theme.appColor.clrPrimaryPink,
      context.theme.appColor.clrPrimaryBlue,
    ];
    final random = Random();
    return predefinedColors[random.nextInt(predefinedColors.length)];
  }

  String initialLetters(final String title) {
    final character = StringBuffer();
    final words = title.split(' ');

    character.write(words[0][0]);
    if (words.length > 1) character.write(words[words.length - 1][0]);
    return character.toString();
  }
}
