import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tcs_dff_types/exceptions.dart';

import 'file_compress_utils.dart';

//below can be added as default params
const int minDefaultHW = 1024;
const int minDefaultHWPhoto = 320;
const int minPassPortPhotoKB = 80;
const int defaultImageQuality = 70;
const int reductionPercent = 10;

class ImageFileCompress {
  Future<File> compressAndGetFile(
    final FileCompressionPolicy fileCompressionPolicy,
  ) async {
    FlutterImageCompress.validator.ignoreCheckExtName = true;
    Uint8List? result;
    switch (fileCompressionPolicy.fileCompressionType) {
      case FileCompressionType.desiredCompression:
        if (fileCompressionPolicy.requiredFileSizeInKB != null) {
          result = await doDesiredCompression(
            sourceFile: fileCompressionPolicy.sourceFile,
            requiredFileSizeInKB: fileCompressionPolicy.requiredFileSizeInKB!,
          );
        } else {
          throw FileSizeRequiredException(
            error: Error(
              title: fileSizeRequiredTitle,
              description: requiredFileSizeErrorMsg,
            ),
          );
        }

      case FileCompressionType.optimum:
        result = await doOptimumCompression(
          sourceFile: fileCompressionPolicy.sourceFile,
        );
        break;
      case FileCompressionType.noCompression:
        return fileCompressionPolicy.sourceFile;
    }

    if (result != null) {
      final tempDir = await getTemporaryDirectory();
      final compressfile = await File(
        '${tempDir.path}/${basename(fileCompressionPolicy.sourceFile.path)}_compress.${fileCompressionPolicy.sourceFile.absolute.path.split('.').last.toLowerCase()}',
      ).create();
      await compressfile.writeAsBytes(result);
      return compressfile;
    }

    return fileCompressionPolicy.sourceFile;
  }

  Future<Uint8List?> doDesiredCompression({
    required final File sourceFile,
    required final int requiredFileSizeInKB,
  }) async {
    Uint8List? result;
    var imageQuality = defaultImageQuality;
    var currentSize = sourceFile.lengthSync();
    while (result == null || requiredFileSizeInKB * 1024 < result.length) {
      final minHW = requiredFileSizeInKB < minPassPortPhotoKB
          ? minDefaultHWPhoto
          : minDefaultHW;
      result = await FlutterImageCompress.compressWithFile(
        sourceFile.absolute.path,
        quality: imageQuality = reduceSize(imageQuality),
        minHeight: minHW,
        minWidth: minHW,
        format: _getCompressFileFormat(
          sourceFile.absolute.path.split('.').last.toLowerCase(),
        ),
      );
      if (result != null) {
        if (result.length == currentSize) {
          return result;
        } else {
          currentSize = result.length;
        }
      }
    }
    return result;
  }

  Future<Uint8List?> doOptimumCompression({
    required final File sourceFile,
  }) async =>
      FlutterImageCompress.compressWithFile(
        sourceFile.absolute.path,
        quality: 20,
        format: _getCompressFileFormat(
          sourceFile.absolute.path.split('.').last.toLowerCase(),
        ),
      );

  CompressFormat _getCompressFileFormat(final String sourceFileImageFormat) {
    switch (sourceFileImageFormat) {
      case 'png':
        return CompressFormat.png;
      case 'jpg':
      case 'jpeg':
        return CompressFormat.jpeg;
      case 'heic':
        return CompressFormat.heic;
      case 'webp':
        return CompressFormat.webp;
      default:
        return CompressFormat.jpeg;
    }
  }

  int reduceSize(final int size) =>
      size - ((size * reductionPercent) / 100).round();
}
