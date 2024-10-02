import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tcs_dff_device_feature/camera/default_camera.dart';
import 'package:tcs_dff_device_feature/custom_file_picker/app_file_picker.dart';
import 'package:tcs_dff_device_feature/file_compress/file_compress_utils.dart';
import 'package:tcs_dff_device_feature/file_compress/image_file_compress.dart';
import 'package:tcs_dff_types/exceptions.dart';

import '../../../utils/enums.dart';

class FileUploaderWidget extends StatefulWidget {
  const FileUploaderWidget({
    super.key,
    required this.content,
    required this.onFileSelected,
    required this.pickFileFrom,
    this.fileTypes,
    this.fileCompressionType = FileCompressionType.optimum,
    this.requiredFileSizeInKB,
  }) : assert(
          (fileCompressionType == FileCompressionType.noCompression &&
                  requiredFileSizeInKB == null) ||
              (fileCompressionType == FileCompressionType.optimum &&
                  requiredFileSizeInKB == null) ||
              (fileCompressionType == FileCompressionType.desiredCompression &&
                  requiredFileSizeInKB != null),
          requiredFileSizeErrorMsg,
        );

  final Function(File?, DevicePermissionException?) onFileSelected;
  final FileSourceType pickFileFrom;
  final List<String>? fileTypes;
  final Widget content;
  final FileCompressionType fileCompressionType;
  final int? requiredFileSizeInKB;

  @override
  State<FileUploaderWidget> createState() => _FileUploaderWidgetState();
}

class _FileUploaderWidgetState extends State<FileUploaderWidget> {
  @override
  Widget build(final BuildContext context) => InkWell(
        onTap: () async {
          try {
            switch (widget.pickFileFrom) {
              case FileSourceType.device:
                widget.onFileSelected(
                  await compressImageFile(
                    await AppFilePicker().openFilePicker(widget.fileTypes!),
                  ),
                  null,
                );
                break;
              case FileSourceType.frontCamera:
                widget.onFileSelected(
                  await compressImageFile(
                    await openPluginCamera(
                      context,
                      0,
                    ),
                  ),
                  null,
                );
                break;
              default:
                await widget.onFileSelected(
                  await compressImageFile(
                    await openPluginCamera(context, 1),
                  ),
                  null,
                );
            }
          } on DevicePermissionException catch (e) {
            widget.onFileSelected(null, e);
          }
        },
        child: widget.content,
      );

  Future<File?> openPluginCamera(
    final BuildContext context,
    final int direction,
  ) async {
    final image = await Camera().openCamera(
      direction: direction,
      context: context,
    );
    return image;
  }

  Future<File?> compressImageFile(final File? selectedFile) async {
    if (selectedFile != null) {
      return await ImageFileCompress().compressAndGetFile(
        FileCompressionPolicy(
          sourceFile: selectedFile,
          fileCompressionType: widget.fileCompressionType,
          requiredFileSizeInKB: widget.requiredFileSizeInKB,
        ),
      );
    }
    return selectedFile;
  }
}
