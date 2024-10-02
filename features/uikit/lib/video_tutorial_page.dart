import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_route/route_navigator.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';
import 'package:tcs_dff_shared_library/logger/logger.dart';
import 'package:tcs_dff_types/config.dart';

class VideoTutorialPage extends StatelessWidget {
  const VideoTutorialPage({super.key});

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    final color = context.theme.appColor;
    final appSize = context.theme.appSize;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: appSize.size20.dp,
                vertical: appSize.size5.dp,
              ),
              child: AudioControlPlayer(
                audioUrl: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
                onLoad: () {
                  print('onLoad');
                },
                onPlay: () {
                  print('onPlay');
                },
                onPause: () {
                  print('onPause');
                },
                onReplay: () {
                  print('onReplay');
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: appSize.size16.dp,
                vertical: appSize.size20.dp,
              ),
              child: Text(
                'Video Tutorials',
                style: context.theme.textTheme.headlineSmall!.copyWith(
                  color: color.clrPrimaryPurple,
                ),
              ),
            ),
            BannerTitleSubtitleWidget(
              thumbnailLink: 'https://picsum.photos/1920/1080',
              title: locale.txt(key: 'videoTitle'),
              titleStyle: context.theme.textTheme.headlineSmall!
                  .copyWith(color: color.greyFullBlack10),
              subTitle: locale.txt(key: 'videoSubTitle'),
              subTitleStyle: context.theme.textTheme.labelMedium!
                  .copyWith(color: color.greyFullBlack10),
              callback: () {
                RouteNavigator.push(
                  context,
                  '/home/uikit/videoTutorialPage/videoPlayer',
                  extra: VideoPlayerConfig(
                    title: 'Butterfly',
                    videoLink: Uri.parse(
                      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: appSize.size10.dp,
            ),
            BannerTitleSubtitleWidget(
              // constants me se laana hai and localization
              thumbnailLink: 'https://picsum.photos/1280/720',
              title: locale.txt(key: 'videoTitle'),
              titleStyle: context.theme.textTheme.headlineSmall!
                  .copyWith(color: color.greyFullBlack10),
              subTitle: locale.txt(key: 'videoSubTitle'),
              subTitleStyle: context.theme.textTheme.labelMedium!
                  .copyWith(color: color.greyFullBlack10),
              callback: () {
                RouteNavigator.push(
                  context,
                  '/home/uikit/videoTutorialPage/videoPlayer',
                  extra: VideoPlayerConfig(
                    title: 'Bee',
                    videoLink: Uri.parse(
                      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: appSize.size10.dp,
            ),
            BannerTitleSubtitleWidget(
              title: locale.txt(key: 'videoTitle'),
              titleStyle: context.theme.textTheme.headlineSmall!
                  .copyWith(color: color.greyFullBlack10),
              subTitle: locale.txt(key: 'videoSubTitle'),
              subTitleStyle: context.theme.textTheme.labelMedium!
                  .copyWith(color: color.greyFullBlack10),
              callback: () {
                RouteNavigator.push(
                  context,
                  '/home/uikit/videoTutorialPage/videoPlayer',
                  extra: VideoPlayerConfig(
                    title: 'Butterfly',
                    videoLink: Uri.parse(
                      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: appSize.size5.dp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: appSize.size10.dp,
                vertical: appSize.size5.dp,
              ),
              child: AudioPlayerWidget(
                text: 'Hello, this is sample test for text to speech',
                staticSvgFilePath: 'images/static_audio_player.svg',
                lottieFilePath: 'json/lottie_animation_audio_player.json',
                lottieFilePackage: 'uikit',
                onPause: () {
                  ConsoleLogger().log('onPause callback');
                },
                onStart: () {
                  ConsoleLogger().log('onStart callback');
                },
                onContinue: () {
                  ConsoleLogger().log('onContinue callback');
                },
                onComplete: () {
                  ConsoleLogger().log('onComplete callback');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
