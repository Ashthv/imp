import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tcs_dff_device_feature/text_to_speech/text_to_speech.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import 'noise_bar_widget.dart';

class AudioPlayerWidget extends StatefulWidget {
  final int noiseBarCount;
  final String text;
  final TextToSpeech? ttsConfig;
  final VoidCallback? onStart;
  final VoidCallback? onPause;
  final VoidCallback? onComplete;
  final VoidCallback? onContinue;
  final String? staticSvgFilePath;
  final String? lottieFilePath;
  final String? lottieFilePackage;

  const AudioPlayerWidget({
    super.key,
    this.noiseBarCount = 30,
    required this.text,
    this.ttsConfig,
    this.onStart,
    this.onPause,
    this.onComplete,
    this.onContinue,
    this.lottieFilePath,
    this.lottieFilePackage,
    this.staticSvgFilePath,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  bool _isPlaying = false;
  bool _isMute = false;
  final _random = <double>[];
  late TextToSpeech tts;
  final LottieAnimationController _controller = LottieAnimationController();

  @override
  void initState() {
    super.initState();
    _setRandomHeights();
    tts = widget.ttsConfig ?? TextToSpeech();
    tts
      ..setStartHandler(widget.onStart ?? () {})
      ..setPauseHandler(widget.onPause ?? () {})
      ..setCompletionHandler(
        widget.onComplete != null
            ? () {
                widget.onComplete!();
                stateChangeAfterPlayback();
              }
            : stateChangeAfterPlayback,
      )
      ..setContinueHandler(widget.onContinue ?? () {});
  }

  @override
  void dispose() {
    tts.stop();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.size5.dp,
        horizontal: size.size17.dp,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.size26.dp),
        color: color.clrPrimaryBlue110,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getMediaButton(context),
          if (widget.lottieFilePath != null &&
              widget.lottieFilePackage != null &&
              widget.staticSvgFilePath != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: _isPlaying,
                  maintainState: true,
                  child: getPlayerAnimationSizedBox(
                    context: context,
                    child: LottieAnimation(
                      filePath: widget.lottieFilePath!,
                      package: widget.lottieFilePackage!,
                      controller: _controller,
                      animateOnLoad: false,
                    ),
                  ),
                ),
                Visibility(
                  visible: !_isPlaying,
                  maintainState: true,
                  child: getPlayerAnimationSizedBox(
                    context: context,
                    child: ImageWidget(
                      fit: BoxFit.contain,
                      imageType: ImageType.assetImage,
                      path: widget.staticSvgFilePath!,
                      package: widget.lottieFilePackage,
                    ),
                  ),
                ),
              ],
            )
          else
            NoiceBarWidget(barHeightList: _random),
          getMuteButton(context),
        ],
      ),
    );
  }

  void _setRandomHeights() {
    for (var i = 0; i < widget.noiseBarCount; i++) {
      _random.add(5.74.w * Random().nextDouble() + .26.w);
    }
  }

  Widget getPlayerAnimationSizedBox({
    required final BuildContext context,
    required final Widget child,
  }) =>
      SizedBox(width: context.theme.appSize.size245.dp, child: child);

  IconButton getMediaButton(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    if (_isPlaying) {
      return IconButton(
        onPressed: () async {
          setState(() {
            _isPlaying = false;
          });
          _controller.mediaAction(MediaAction.stop);
          await tts.pause();
        },
        icon: Icon(
          Icons.pause_circle_outline_rounded,
          color: color.clrPrimaryBlue,
          size: size.size32.dp,
        ),
      );
    } else {
      return IconButton(
        onPressed: () async {
          setState(() {
            _isPlaying = true;
          });
          _controller.mediaAction(MediaAction.play);
          await tts.speak(widget.text);
        },
        icon: Icon(
          Icons.play_circle_outline_rounded,
          color: color.clrPrimaryBlue,
          size: size.size32.dp,
        ),
      );
    }
  }

  IconButton getMuteButton(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    if (_isMute) {
      return IconButton(
        onPressed: () {
          setState(() {
            _isMute = false;
          });

          tts.setVolume(0.5);
          if (_isPlaying) {
            tts
              ..pause()
              ..speak(widget.text);
          }
        },
        icon: Icon(
          Icons.volume_off_outlined,
          color: color.clrPrimaryBlue,
          size: size.size32.dp,
        ),
      );
    } else {
      return IconButton(
        onPressed: () {
          setState(() {
            _isMute = true;
          });

          tts.setVolume(0);
          if (_isPlaying) {
            tts
              ..pause()
              ..speak(widget.text);
          }
        },
        icon: Icon(
          Icons.volume_up_outlined,
          color: color.clrPrimaryBlue,
          size: size.size32.dp,
        ),
      );
    }
  }

  void stateChangeAfterPlayback() {
    setState(() {
      _isPlaying = false;
    });
    _controller.mediaAction(MediaAction.stop);
  }
}
