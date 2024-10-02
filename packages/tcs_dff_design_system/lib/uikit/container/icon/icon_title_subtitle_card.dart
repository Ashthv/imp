import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import 'icon_title_subtitle_icon.dart';

class IconTitleSubtitleCard extends StatelessWidget {
  IconTitleSubtitleCard({
    super.key,
    required this.title,
    this.subtitle,
    this.leftIcon,
    this.rightIcon,
    this.package,
  });

  final String title;
  final String? subtitle;
  final String? leftIcon;
  final String? rightIcon;
  final String? package;

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    return Center(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              size.size12.dp,
            ),
          ),
          side: BorderSide(
            width: size.size1.dp / size.size2.dp,
            color: color.greyLighterGrey70,
          ),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(
            size.size24.dp,
            size.size20.dp,
            size.size16.dp,
            size.size16.dp,
          ),
          color: color.greyFullWhite120,
          child: IconTitleSubtitleIcon(
            title: title,
            subtitle: subtitle,
            leftImagePath: leftIcon,
            rightImagePath: rightIcon,
            package: package,
          ),
        ),
      ),
    );
  }
}
