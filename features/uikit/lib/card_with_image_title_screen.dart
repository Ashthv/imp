import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/card/card_with_image_title.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class CardWithImageAndTitleScreen extends StatelessWidget {
  const CardWithImageAndTitleScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;

    return Scaffold(
      body: Container(
        child: Row(
          children: [
            CardWithImageAndTitle(
              iconText: locale.txt(key: 'knowMore'),
              imagePackage: 'uikit',
              imagePath: 'images/know_more.svg',
              callback: () {},
            ),
            CardWithImageAndTitle(
              iconText: locale.txt(key: 'tutorials'),
              imagePackage: 'uikit',
              imagePath: 'images/ic_video_tutorials.svg',
              callback: () {},
            ),
          ],
        ),
      ),
    );
  }
}
