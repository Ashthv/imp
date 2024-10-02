import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/utils/snackbar_utils.dart';
import 'package:tcs_dff_device_feature/custom_file_picker/app_file_picker.dart';
import 'package:tcs_dff_device_feature/custom_file_picker/file_picker_utils.dart';
import 'package:tcs_dff_device_feature/share_widget/share_widget.dart';
import 'package:tcs_dff_types/exceptions.dart';

class DemoShareWidget extends StatefulWidget {
  const DemoShareWidget({super.key});

  @override
  State<DemoShareWidget> createState() => _DemoShareWidgetState();
}

class _DemoShareWidgetState extends State<DemoShareWidget> {
  String sharetText = 'The share text is ';
  Uri shareUrl = Uri();
  late AppFilePicker _appFilePicker;
  String fileName = '';
  String fileSize = '';
  String filePath = '';
  File? selectedFile;
  File? finalImagePath;

  @override
  void initState() {
    super.initState();
    _appFilePicker = AppFilePicker();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  ShareWidget.shareText(
                    text: 'THE SHARE WIDGET',
                  );
                },
                child: const Text('Invoke Share Widget Text Method'),
              ),
              Text(sharetText),
              ElevatedButton(
                onPressed: () {
                  ShareWidget.shareUrl(
                    url: Uri.parse('http://google.com'),
                  );
                },
                child: const Text('Invoke Share Widget Uri Method'),
              ),
              Text(shareUrl.toString()),
              ElevatedButton(
                onPressed: () async {
                  try {
                    selectedFile = await _appFilePicker.openFilePicker([
                      FileType.jpg.name,
                      FileType.png.name,
                      FileType.pdf.name,
                    ]);
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
              ElevatedButton(
                onPressed: () async {
                  if (selectedFile == null) {
                    showSnackBar(
                      context: context,
                      snackbarType: SnackbarType.error,
                      message: 'No File Selected',
                    );
                    return;
                  }
                  // Currently only sending one file because of file picker's
                  // limitation
                  await ShareWidget.shareFiles(
                    files: [selectedFile!],
                    textWithFile: 'The file selected from file picker is',
                  );
                },
                child: const Text('Invoke Share Widget File Method'),
              ),
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
