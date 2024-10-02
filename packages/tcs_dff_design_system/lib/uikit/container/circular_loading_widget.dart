import 'package:flutter/material.dart';
import '../animation/lottie_animation.dart';

class CircularLoadingWidget extends StatelessWidget {
  final String filePath;
  final String package;
  const CircularLoadingWidget({
    super.key,
    required this.filePath,
    required this.package,
  });
  @override
  Widget build(final BuildContext context) => LottieAnimation(
        filePath: filePath,
        package: package,
      );
}
