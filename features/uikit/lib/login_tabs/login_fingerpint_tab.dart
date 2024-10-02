import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';

class FingerprintTab extends StatelessWidget {
  const FingerprintTab({super.key});

  @override
  Widget build(final BuildContext context) => ImageWidget(
        imageType: ImageType.assetImage,
        path: 'images/emv_chip.png',
        package: 'uikit',
      );
}
