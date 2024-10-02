import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tcs_dff_types/exceptions.dart';
import '../permission/device_permission_manager.dart';
import '../permission/permission_types.dart';
import '../utils/string_constants.dart';
import 'camera_screen.dart';

class Camera {
  late CameraController controller;
  late List<CameraDescription> cameras;
  late List<File?> file;
  late DevicePermissionManager devicePermissionManager;

  Camera() {
    devicePermissionManager = DevicePermissionManager();
  }

  Future<File?> openCamera({
    required final int direction,
    required final BuildContext context,
  }) async {
    final status = await devicePermissionManager.checkAndRequestPermission(
      DevicePermission.camera,
    );
    if (status.isGranted) {
      cameras = await availableCameras();

      controller = CameraController(
        cameras[direction],
        ResolutionPreset.high,
        enableAudio: false,
      );

      await controller.initialize();

      if (context.mounted) {
        file = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (final context) => CameraScreen(
              controller: controller,
              direction: direction,
            ),
          ),
        ) as List<File?>;
      }

      return (file[0] == null) ? null : File(file[0]!.path);
    } else {
      throw DevicePermissionException(
        error: Error(
          title: permissionDenyMessage,
          description: status.toString(),
        ),
      );
    }
  }
}
