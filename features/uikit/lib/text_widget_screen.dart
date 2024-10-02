import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/image/image_widget.dart';
import 'package:tcs_dff_design_system/uikit/foundation/text_widget.dart';
import 'package:tcs_dff_design_system/utils/image_type.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class TextWidgetScreen extends StatelessWidget {
  const TextWidgetScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    return TextWidget(
      text: locale.txt(key: 'timerText'),
      styledTextList: ['attempts', 'try again', 'October'],
      widget: ImageWidget(
        imageType: ImageType.assetImage,
        path: 'images/error.png',
        package: 'uikit',
      ),
    );
  }
}
