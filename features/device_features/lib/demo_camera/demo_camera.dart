import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tcs_dff_device_feature/camera/default_camera.dart';

class DemoCamera extends StatefulWidget {
  const DemoCamera({super.key});

  @override
  State<DemoCamera> createState() => _DemoCameraState();
}

class _DemoCameraState extends State<DemoCamera> {
  final initCamera = Camera();
  File? resultPicture;

  @override
  void initState() {
    rotatedImage();
    super.initState();
  }

  Future<File?>? openPluginCamera(final BuildContext context) async =>
      resultPicture = await initCamera.openCamera(
        direction: 0,
        context: context,
      );

  Widget rotatedImage() => resultPicture != null
      ? Image.file(
          File(resultPicture!.path),
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.7,
        )
      : const Text('Image not available');

  @override
  Widget build(final BuildContext context) => SafeArea(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await openPluginCamera(context);
                  setState(rotatedImage);
                },
                child: const Text('Open camera'),
              ),
            ),
            rotatedImage()
          ,],
        ),
      );
}
