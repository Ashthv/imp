import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tcs_dff_types/exceptions.dart';
import '../utils/string_constants.dart';
import 'preview_page.dart';

class CameraScreen extends StatefulWidget {
  final CameraController controller;
  final int direction;

  const CameraScreen({
    super.key,
    required this.controller,
    required this.direction,
  });

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late List<File?>? isPictureConfirmed;

  @override
  Widget build(final BuildContext context) => SafeArea(
        child: Stack(
          children: [
            CameraPreview(widget.controller),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  color: Colors.black,
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      takePicture(context);
                    },
                    iconSize: 60,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Future<dynamic> takePicture(final BuildContext context) async {
    if (!widget.controller.value.isInitialized) {
      return;
    }
    if (widget.controller.value.isTakingPicture) {
      return;
    }
    try {
      await widget.controller.setFlashMode(FlashMode.off);

      final picture = await widget.controller.takePicture();

      if (context.mounted) {
        isPictureConfirmed = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (final context) => PreviewPage(
              picture: picture,
              direction: widget.direction,
            ),
          ),
        );
      }

      if (isPictureConfirmed?[0] != null && context.mounted) {
        Navigator.pop(context, [isPictureConfirmed?[0]]);
      }
    } on CameraException catch (e) {
      NativeException(
        error: Error(
          description: e.toString(),
          title: cameraExceptionTitle,
        ),
      );
    }
  }
}
