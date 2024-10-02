import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tcs_dff_types/exceptions.dart';

import '../permission/device_permission_manager.dart';
import '../permission/permission_types.dart';
import '../utils/string_constants.dart';
import 'file_picker_utils.dart' as filepickerutils;

class AppFilePicker {
  late DevicePermissionManager devicePermissionManager;
  AppFilePicker() {
    devicePermissionManager = DevicePermissionManager();
  }

  Future<File?> openFilePicker(
    final List<String> fileType,
  ) async =>
      _pickFiles(fileType);

  Future<File?> openImagePicker() async => _pickFiles(<String>[
        filepickerutils.FileType.png.name,
        filepickerutils.FileType.jpg.name,
      ]);

  Future<File?> _pickFiles(final List<String> fileType) async {
    final status = await devicePermissionManager
        .checkAndRequestPermission(await getStoragePermission());
    if (status.isGranted) {
      final filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: fileType,
      );

      return filePickerResult != null
          ? File(filePickerResult.files.single.path!)
          : null;
    } else {
      throw DevicePermissionException(
        error:
            Error(title: permissionDenyMessage, description: status.toString()),
      );
    }
  }
}

Future<DevicePermission> getStoragePermission() async {
  if (Platform.isAndroid) {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final androidInfo = await deviceInfoPlugin.androidInfo;
    if (androidInfo.version.sdkInt >= 33) {
      return DevicePermission.manageExternalStorage;
    } else {
      return DevicePermission.storage;
    }
  }

  return DevicePermission.storage;
}
