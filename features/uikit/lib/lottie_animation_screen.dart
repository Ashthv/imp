import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';

class LottieAnimationScreen extends StatefulWidget {
  @override
  State<LottieAnimationScreen> createState() => _LottieAnimationScreenState();
}

class _LottieAnimationScreenState extends State<LottieAnimationScreen> {
  bool _isPlaying = true;
  LottieAnimationController controller = LottieAnimationController();
  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieAnimation(
              filePath: 'json/lottie_animation_sample.json',
              package: 'uikit',
              controller: controller,
            ),
            getMediaButton(context),
          ],
        ),
      );

  IconButton getMediaButton(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    if (_isPlaying) {
      return IconButton(
        onPressed: () async {
          setState(() {
            _isPlaying = false;
          });
          controller.mediaAction(MediaAction.stop);
        },
        icon: Icon(
          Icons.pause_circle_outline_rounded,
          color: color.clrPrimaryBlue,
          size: size.size32,
        ),
      );
    } else {
      return IconButton(
        onPressed: () async {
          setState(() {
            _isPlaying = true;
          });
          controller.mediaAction(MediaAction.play);
        },
        icon: Icon(
          Icons.play_circle_outline_rounded,
          color: color.clrPrimaryBlue,
          size: size.size32,
        ),
      );
    }
  }
}
