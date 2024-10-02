import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/overlay_icon_title_subtitle.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class DigitalProducts {
  final String productImage;
  final String producatName;
  final String productDescription;
  DigitalProducts(
    this.productImage,
    this.producatName,
    this.productDescription,
  );
}

class OverlayIconTitleSubtitleScreeen extends StatefulWidget {
  const OverlayIconTitleSubtitleScreeen({super.key});
  @override
  State<OverlayIconTitleSubtitleScreeen> createState() =>
      _OverlayIconTitleSubtitleScreeenState();
}

class _OverlayIconTitleSubtitleScreeenState
    extends State<OverlayIconTitleSubtitleScreeen> {
  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: OverlayIconTitleSubtitle(
              onTapped: () {},
              imagePackage: 'uikit',
              imagePath: 'images/pigybank.png',
              title: locale.txt(key: 'savingaccount'),
              subTitle: locale.txt(key: 'keepingyourmoneysafe'),
            ),
          ),
        ],
      ),
    );
  }
}
