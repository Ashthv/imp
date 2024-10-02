import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/icon/icon_title_subtitle_card.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class IconTitleSubtitleCardScreen extends StatelessWidget {
  const IconTitleSubtitleCardScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    return Column(
      children: [
        IconTitleSubtitleCard(
          title: locale.txt(key: 'titleSubtitleHeading'),
          subtitle: locale.txt(key: 'titleSubtitleSubheading'),
          leftIcon: 'images/choose_doc.png',
          rightIcon: 'images/chevron_right.png',
          package: 'uikit',
        ),
        IconTitleSubtitleCard(
          title: locale.txt(key: 'titleSubtitleHeading'),
          subtitle: locale.txt(key: 'titleSubtitleSubheading'),
          rightIcon: 'images/chevron_right.png',
          package: 'uikit',
        ),
        IconTitleSubtitleCard(
          title: locale.txt(key: 'titleSubtitleHeading'),
          subtitle: locale.txt(key: 'titleSubtitleSubheading'),
        ),
        IconTitleSubtitleCard(
          title: locale.txt(key: 'titleSubtitleHeading'),
        ),
        IconTitleSubtitleCard(
          title: locale.txt(key: 'titleSubtitleHeading'),
          leftIcon: 'images/choose_doc.png',
          rightIcon: 'images/chevron_right.png',
          package: 'uikit',
        ),
      ],
    );
  }
}
