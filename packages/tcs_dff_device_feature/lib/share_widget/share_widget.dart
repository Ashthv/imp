import 'dart:io';

import 'package:share_plus/share_plus.dart';

class ShareWidget {
  static Future<void> shareText({required final String text}) async {
    await Share.share(text);
  }

  static Future<void> shareUrl({required final Uri url}) async {
    await Share.shareUri(url);
  }

  static Future<void> shareFiles({
    required final List<File> files,
    final String? textWithFile,
  }) async {
    final xFileList = <XFile>[];
    for (final file in files) {
      xFileList.add(XFile(file.path));
    }
    await Share.shareXFiles(
      xFileList,
      text: textWithFile,
    );
  }
}
