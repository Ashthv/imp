import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tcs_dff_device_feature/custom_file_picker/app_file_picker.dart';
import 'package:tcs_dff_device_feature/custom_file_picker/file_picker_utils.dart';
import 'package:tcs_dff_types/exceptions.dart';

class DemoFilePicker extends StatefulWidget {
  const DemoFilePicker({super.key});

  @override
  State<DemoFilePicker> createState() => _DemoFilePickerState();
}

class _DemoFilePickerState extends State<DemoFilePicker> {
  late AppFilePicker _appFilePicker;
  String fileName = '';
  String fileSize = '';
  String filePath = '';
  File? selectedFile;

  @override
  void initState() {
    super.initState();
    _appFilePicker = AppFilePicker();
  }

  @override
  Widget build(final BuildContext context) => Center(
        child: Builder(
          builder: (final context) => Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  try {
                    selectedFile = await _appFilePicker
                        .openFilePicker([FileType.png.name]);
                    if (selectedFile != null) {
                      fileName = getFileName(selectedFile!.path);
                      filePath = selectedFile!.path;
                      fileSize = getFileSize(selectedFile!.lengthSync())
                          .toStringAsFixed(2);
                      setState(() {});
                    }
                  } on DevicePermissionException catch (e) {
                    showErrorMessageOnSnackBar(e);
                  }
                },
                child: const Text('Open File Picker'),
              ),
              const Text('Selected File Details'),
              const SizedBox(
                height: 10,
              ),
              Text('File Name : $fileName'),
              const SizedBox(
                height: 10,
              ),
              Text('File Path : $filePath'),
              const SizedBox(
                height: 10,
              ),
              Text('Size: $fileSize KB'),
            ],
          ),
        ),
      );

  double getFileSize(final int fileSizeInKB) => fileSizeInKB / 1024;

  String getFileName(final String filePath) {
    final splitPath = filePath.split('/');
    if (splitPath.isNotEmpty) {
      return splitPath[splitPath.length - 1];
    } else {
      return filePath;
    }
  }

  void showErrorMessageOnSnackBar(final DevicePermissionException e) {
    final snackBar = SnackBar(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${e.exceptionDetails}', style: const TextStyle(fontSize: 16.0)),
          const SizedBox(
            height: 4,
          ),
          Text('${e.exceptionDetails}', style: const TextStyle(fontSize: 16.0)),
        ],
      ),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
