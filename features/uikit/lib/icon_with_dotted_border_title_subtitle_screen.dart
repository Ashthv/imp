import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/icon/icon_with_dotted_border_title_subtitle.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class IconWithDottedBorderTitleSubtitleScreen extends StatelessWidget {
  const IconWithDottedBorderTitleSubtitleScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    return IconWithDottedBorderTitleSubtitle(
      title: locale.txt(key: 'detailProductDescription7'),
      subTitle: locale.txt(key: 'detailProductDescription'),
      imagePath: 'images/completely_paperless.svg',
      package: 'uikit',
    );
  }
}
