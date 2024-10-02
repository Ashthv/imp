import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class CircularLoadingScreen extends StatelessWidget {
  const CircularLoadingScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    return Scaffold(
      backgroundColor: color.clrPrimaryBlue10,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularLoadingWidget(
              filePath: 'json/lottie_circular_loading_animation.json',
              package: 'uikit',
            ),
            SizedBox(height: size.size20.dp),
            TextWidget(
              text: 'Authentication in progress',
              style: textStyle.h218pxbold.copyWith(
                color: color.greyFullWhite120,
              ),
            ),
            SizedBox(height: size.size4.dp),
            TextWidget(
              text: 'Please wait...',
              style: textStyle.bodyCopy2Small16Regular.copyWith(
                color: color.clrPrimaryBlue40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
