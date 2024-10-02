import 'dart:io';

class FileCompressionPolicy {
  FileCompressionType fileCompressionType;
  File sourceFile;
  int? requiredFileSizeInKB;
  FileCompressionPolicy({
    this.fileCompressionType = FileCompressionType.optimum,
    required this.sourceFile,
    this.requiredFileSizeInKB,
  });
}

enum FileCompressionType {
  desiredCompression,
  optimum,
  noCompression,
}

const String fileSizeRequiredTitle = 'File Size required';
const String requiredFileSizeErrorMsg =
    '''FileCompressionType.desiredCompression required requiredFileSizeInKB parameter''';
