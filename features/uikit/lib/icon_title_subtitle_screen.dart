import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/icon/icon_title_subtitle_icon.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class IconTitleSubtitleScreen extends StatelessWidget {
  const IconTitleSubtitleScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    return Scaffold(
      backgroundColor: color.greyFullWhite120,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            IconTitleSubtitleIcon(
              title: locale.txt(key: 'titleSubtitleHeading'),
              subtitle: locale.txt(key: 'titleSubtitleSubheading'),
              leftImagePath: 'images/choose_doc.png',
              package: 'uikit',
              isIllusioned: true,
              // rightImagePath: 'images/chevron_right.png',
            ),
            SizedBox(
              height: size.size50.dp,
            ),
            IconTitleSubtitleIcon(
              title: locale.txt(key: 'titleSubtitleHeading'),
              // subtitle: locale.txt(key: 'titleSubtitleSubheading'),
              leftImagePath: 'images/choose_doc.png',
              package: 'uikit',
              isIllusioned: true,
              // rightImagePath: 'images/chevron_right.png',
            ),
            SizedBox(
              height: size.size50.dp,
            ),
            IconTitleSubtitleIcon(
              title: locale.txt(key: 'titleSubtitleHeading'),
              subtitle: locale.txt(key: 'titleSubtitleSubheading'),
              // leftImagePath: 'images/choose_doc.png',
              package: 'uikit',
              isIllusioned: true,
              // rightImagePath: 'images/chevron_right.png',
            ),
            SizedBox(
              height: size.size50.dp,
            ),
            IconTitleSubtitleIcon(
              title: locale.txt(key: 'titleSubtitleHeading'),
              subtitle: locale.txt(key: 'titleSubtitleSubheading'),
              leftImagePath: 'images/choose_doc.png',
              package: 'uikit',
              // rightImagePath: 'images/chevron_right.png',
            ),
            SizedBox(
              height: size.size50.dp,
            ),
            IconTitleSubtitleIcon(
              title: locale.txt(key: 'titleSubtitleHeading'),
              subtitle: locale.txt(key: 'titleSubtitleSubheading'),
              // leftImagePath: 'images/choose_doc.png',
              package: 'uikit',
              // rightImagePath: 'images/chevron_right.png',
            ),
            SizedBox(
              height: size.size50.dp,
            ),
            IconTitleSubtitleIcon(
              title: locale.txt(key: 'titleSubtitleHeading'),
              subtitle: locale.txt(key: 'titleSubtitleSubheading'),
              leftImagePath: 'images/choose_doc.png',
              rightImagePath: 'images/chevron_right.png',
              package: 'uikit',
            ),
          ],
        ),
      ),
    );
  }
}
