import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/video_player_widget.dart';

class VideoPlayerPage extends StatefulWidget {
  final String title;
  final Uri videoLink;
  const VideoPlayerPage({
    super.key,
    required this.title,
    required this.videoLink,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  @override
  Widget build(final BuildContext context) => VideoPlayerWidget(
        title: widget.title,
        videoLink: widget.videoLink,
      );
}
