import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tcs_dff_shared_library/logger/logger.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class AudioControlPlayer extends StatefulWidget {
  final String? staticAnimationSvgPath;
  final String? animationJsonPath;
  final String? animationPackage;
  final VoidCallback? onLoad;
  final VoidCallback? onPlay;
  final VoidCallback? onPause;
  final VoidCallback? onReplay;
  final String audioUrl;

  const AudioControlPlayer({
    super.key,
    this.staticAnimationSvgPath = 'images/static_audio_player.svg',
    this.animationJsonPath = 'json/lottie_animation_audio_player.json',
    this.animationPackage = 'uikit',
    this.onLoad,
    this.onPlay,
    this.onPause,
    this.onReplay,
    required this.audioUrl,
  });

  @override
  State<AudioControlPlayer> createState() => _AudioControlPlayerState();
}

class _AudioControlPlayerState extends State<AudioControlPlayer>
    with WidgetsBindingObserver {
  final _player = AudioPlayer();
  final _animationController = LottieAnimationController();
  final _consoleLogger = ConsoleLogger();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // Try to load audio from a source and catch any errors.
    try {
      // await _player.setAudioSource(
      //   AudioSource.asset(
      //     'assets/images/sample_audio.m4a',
      //     package: 'tcs_dff_design_system',
      //   ),
      // );
      await _player.setAudioSource(
        AudioSource.uri(Uri.parse(widget.audioUrl)),
      );
    } on PlayerException catch (e) {
      _consoleLogger.error('Error while loading audio: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
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
          ControlButtons(
            player: _player,
            animationController: _animationController,
            onLoad: widget.onLoad,
            onPause: widget.onPause,
            onPlay: widget.onPlay,
            onReplay: widget.onReplay,
          ),
          AudioWave(
            player: _player,
            animationController: _animationController,
            animationPackage: widget.animationPackage,
            animationJsonPath: widget.animationJsonPath,
            staticAnimationSvgPath: widget.staticAnimationSvgPath,
          ),
          MuteUnmuteButton(player: _player),
        ],
      ),
    );
  }
}

class AudioWave extends StatelessWidget {
  const AudioWave({
    super.key,
    required this.player,
    required this.animationController,
    this.staticAnimationSvgPath,
    this.animationJsonPath,
    this.animationPackage,
  });

  final AudioPlayer player;
  final LottieAnimationController animationController;
  final String? staticAnimationSvgPath;
  final String? animationJsonPath;
  final String? animationPackage;

  Stream<PositionData> get _positionDataStream => Rx.combineLatest4<Duration,
          Duration, Duration?, PlayerState, PositionData>(
        player.positionStream,
        player.bufferedPositionStream,
        player.durationStream,
        player.playerStateStream,
        (
          final position,
          final bufferedPosition,
          final duration,
          final playerState,
        ) =>
            PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
          playerState,
        ),
      );

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final style = context.theme.appTextStyles;
    return StreamBuilder<PositionData>(
      stream: _positionDataStream,
      builder: (final context, final snapshot) {
        final positionData = snapshot.data;
        final duration = positionData?.duration ?? Duration.zero;
        final position = positionData?.position ?? Duration.zero;
        final playing = positionData?.playerState.playing ?? false;
        final remaining = duration - position;
        final processingState = positionData?.playerState.processingState;
        final showLottieAnimation =
            playing && processingState != ProcessingState.completed;
        final showStaticAnimation =
            !playing || processingState == ProcessingState.completed;
        final showTimer = !(processingState == null ||
            processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering);
        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      flex: showLottieAnimation ? 1 : 0,
                      child: Visibility(
                        visible: showLottieAnimation,
                        maintainState: true,
                        child: LottieAnimation(
                          filePath: animationJsonPath!,
                          package: animationPackage!,
                          controller: animationController,
                          animateOnLoad: false,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: showStaticAnimation ? 1 : 0,
                      child: Visibility(
                        visible: showStaticAnimation,
                        maintainState: true,
                        child: ImageWidget(
                          fit: BoxFit.fitWidth,
                          imageType: ImageType.assetImage,
                          path: staticAnimationSvgPath!,
                          package: animationPackage,
                          color: color.greyDarkGrey30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: showTimer,
                child: Padding(
                  padding: EdgeInsets.only(left: size.size12.dp),
                  child: TextWidget(
                    text: RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                            .firstMatch('$remaining')
                            ?.group(1) ??
                        '$remaining',
                    style: style.h414pxRegular.copyWith(
                      fontSize: size.size14.sp,
                      color: color.greyDarkestGrey20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;
  final LottieAnimationController animationController;
  final VoidCallback? onLoad;
  final VoidCallback? onPlay;
  final VoidCallback? onPause;
  final VoidCallback? onReplay;

  const ControlButtons({
    super.key,
    required this.player,
    required this.animationController,
    this.onLoad,
    this.onPlay,
    this.onPause,
    this.onReplay,
  });

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    return StreamBuilder<PlayerState>(
      stream: player.playerStateStream,
      builder: (final context, final snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          onLoad?.call();
          return IconButton(
            onPressed: () {},
            icon: SizedBox(
              width: size.size30.dp,
              height: size.size30.dp,
              child: CircularProgressIndicator(color: color.clrPrimaryBlue),
            ),
          );
        } else if (playing != true) {
          return IconButton(
            icon: Icon(
              Icons.play_circle_outline_rounded,
              color: color.clrPrimaryBlue,
              size: size.size32.dp,
            ),
            onPressed: () {
              animationController.mediaAction(MediaAction.play);
              player.play();
              onPlay?.call();
            },
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: Icon(
              Icons.pause_circle_outline_rounded,
              color: color.clrPrimaryBlue,
              size: size.size32.dp,
            ),
            onPressed: () {
              animationController.mediaAction(MediaAction.stop);
              player.pause();
              onPause?.call();
            },
          );
        } else {
          animationController.mediaAction(MediaAction.stop);
          return IconButton(
            icon: Icon(
              Icons.replay_outlined,
              color: color.clrPrimaryBlue,
              size: size.size32.dp,
            ),
            onPressed: () {
              animationController.mediaAction(MediaAction.play);
              player.seek(Duration.zero);
              onReplay?.call();
            },
          );
        }
      },
    );
  }
}

class MuteUnmuteButton extends StatefulWidget {
  const MuteUnmuteButton({super.key, required this.player});

  final AudioPlayer player;

  @override
  State<MuteUnmuteButton> createState() => _MuteUnmuteButtonState();
}

class _MuteUnmuteButtonState extends State<MuteUnmuteButton> {
  bool _isMute = false;

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    return IconButton(
      onPressed: () {
        if (_isMute) {
          _isMute = false;
          widget.player.setVolume(1);
        } else {
          _isMute = true;
          widget.player.setVolume(0);
        }

        setState(() {});
      },
      icon: Icon(
        _isMute ? Icons.volume_off_outlined : Icons.volume_up_outlined,
        color: color.clrPrimaryBlue,
        size: size.size32.dp,
      ),
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
  final PlayerState playerState;

  PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
    this.playerState,
  );
}
