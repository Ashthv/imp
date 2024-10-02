import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationController {
  late void Function(MediaAction mediaAction) mediaAction;
  late void Function() togglePlayback;
}

class LottieAnimation extends StatefulWidget {
  final LottieFileType? lottieFileType;
  final String filePath;
  final String? package;
  final LottieAnimationController? controller;
  final bool animateOnLoad;

  LottieAnimation({
    super.key,
    this.lottieFileType = LottieFileType.assetFile,
    required this.filePath,
    this.package,
    this.controller,
    this.animateOnLoad = true,
  });

  @override
  State<LottieAnimation> createState() => _LottieAnimationState(controller);
}

class _LottieAnimationState extends State<LottieAnimation>
    with TickerProviderStateMixin {
  late AnimationController _lottieAnimationController;

  _LottieAnimationState(final LottieAnimationController? _controller) {
    if (_controller != null) {
      _controller
        ..mediaAction = mediaAction
        ..togglePlayback = togglePlayback;
    }
  }

  @override
  void initState() {
    super.initState();
    _lottieAnimationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _lottieAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    if (widget.lottieFileType == LottieFileType.assetFile) {
      return Lottie.asset(
        widget.filePath,
        package: widget.package,
        controller: _lottieAnimationController,
        onLoaded: (final composition) {
          _lottieAnimationController.duration = composition.duration;
          if (widget.animateOnLoad) {
            _lottieAnimationController
              ..forward()
              ..repeat();
          }
        },
      );
    } else {
      return Lottie.network(widget.filePath);
    }
  }

  void mediaAction(final MediaAction mediaAction) {
    switch (mediaAction) {
      case MediaAction.play:
        _lottieAnimationController.forward();
        _lottieAnimationController.repeat();
        break;

      case MediaAction.stop:
        _lottieAnimationController.stop();
        break;
    }
  }

  void togglePlayback() {
    if (_lottieAnimationController.isAnimating) {
      _lottieAnimationController.stop();
    } else {
      _lottieAnimationController
        ..forward()
        ..repeat();
    }
  }
}

enum LottieFileType {
  networkFile,
  assetFile,
}

enum MediaAction {
  play,
  stop,
}
