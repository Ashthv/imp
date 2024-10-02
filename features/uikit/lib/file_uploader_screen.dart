import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/enums.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_device_feature/file_compress/file_compress_utils.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';
import 'package:tcs_dff_types/exceptions.dart';

class FileUploaderScreen extends StatefulWidget {
  const FileUploaderScreen({super.key});

  @override
  State<FileUploaderScreen> createState() => _FileUploaderScreenState();
}

class _FileUploaderScreenState extends State<FileUploaderScreen> {
  File? selectedFiles;
  bool isError = false;

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    final size = context.theme.appSize;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.size20.dp),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10.dp,
              ),
              FileUploaderWidget(
                pickFileFrom: FileSourceType.frontCamera,
                content: FileUploadContent(
                  subtitle: 'Maximum size: 1MB (png, jpg)',
                  title: locale.txt(key: 'fileUploaderMessage'),
                  uploadType: UploadType.selfieOrProfile,
                ),
                onFileSelected:
                    (final file, final DevicePermissionException? exception) {
                  if (file != null) {
                    setState(() {
                      selectedFiles = file;
                    });
                  } else if (exception != null) {
                    setState(() {
                      isError = true;
                    });
                  }
                },
              ),
              SizedBox(
                height: 10.dp,
              ),
              FileUploaderWidget(
                pickFileFrom: FileSourceType.backCamera,
                content: FileUploadContent(
                  title: locale.txt(key: 'fileUploaderMessage'),
                  subtitle: 'Maximum size: 1MB (png, jpg)',
                  uploadType: UploadType.selfie,
                ),
                onFileSelected:
                    (final file, final DevicePermissionException? exception) {
                  if (file != null) {
                    setState(() {
                      selectedFiles = file;
                    });
                  } else if (exception != null) {
                    setState(() {
                      isError = true;
                    });
                  }
                },
              ),
              SizedBox(
                height: 10.dp,
              ),
              FileUploaderWidget(
                pickFileFrom: FileSourceType.device,
                fileTypes: ['jpg'],
                content: FileUploadContent(
                  uploadType: UploadType.document,
                  title: locale.txt(key: 'fileUploaderMessage'),
                  subtitle: locale.txt(key: 'fileUploaderSubtitle'),
                ),
                fileCompressionType: FileCompressionType.desiredCompression,
                requiredFileSizeInKB: 50,
                onFileSelected:
                    (final file, final DevicePermissionException? exception) {
                  if (file != null) {
                    setState(() {
                      selectedFiles = file;
                    });
                  } else if (exception != null) {
                    setState(() {
                      isError = true;
                    });
                  }
                },
              ),
              SizedBox(
                height: 10.dp,
              ),
              UploadedFileWidget(
                uploadType: UploadType.document,
                fileName: 'document name',
                onCancelPressed: () {},
              ),
              SizedBox(
                height: 10.dp,
              ),
              Container(
                height: 60.dp,
                width: 166.dp,
                child: FileUploaderWidget(
                  pickFileFrom: FileSourceType.device,
                  fileTypes: ['png', 'jpeg'],
                  content: const UploadButton(
                    isContentHorizontal: true,
                    name: 'Upload Photo',
                    icon: Icons.file_upload_outlined,
                  ),
                  onFileSelected:
                      (final file, final DevicePermissionException? exception) {
                    if (file != null) {
                      setState(() {
                        selectedFiles = file;
                      });
                    } else if (exception != null) {
                      setState(() {
                        isError = true;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10.dp,
              ),
              FileUploaderWidget(
                pickFileFrom: FileSourceType.device,
                fileTypes: ['png'],
                content: const UploadButton(
                  name: 'Upload Photo',
                  icon: Icons.file_upload_outlined,
                ),
                onFileSelected:
                    (final file, final DevicePermissionException? exception) {
                  if (file != null) {
                    setState(() {
                      selectedFiles = file;
                    });
                  } else if (exception != null) {
                    setState(() {
                      isError = true;
                    });
                  }
                },
              ),
              SizedBox(
                height: 10.dp,
              ),
              FileUploadProgressBarWidget(
                durationLeft: '2 sec',
                onCancelPressed: () {},
                progreesValue: 0.2,
                activeBytes: '1000 kb',
                title: 'Wireframing_11_01_2024.png',
                uploadType: UploadType.document,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
