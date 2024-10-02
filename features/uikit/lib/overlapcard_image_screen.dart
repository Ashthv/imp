import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/overlapping_card/overlap_card_image.dart';

class OverlapCardImageScreen extends StatelessWidget {
  const OverlapCardImageScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;

    return OverlappingCardImage(
      imagePath: 'images/mobile_phone.png',
      package: 'uikit',
      imagePadding: EdgeInsets.only(top: size.size13, bottom:size.size13, ),
      boxFit: BoxFit.contain,
    );
  }
}
