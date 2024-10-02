import 'dart:convert';
import 'dart:io';

import 'package:tcs_dff_tools/codegen/engine/generate.dart' as codegen;
import 'package:tcs_dff_tools/codegen/specification/specification.dart';

void main(final List<String> args) {
  exitCode = 0; // 0 means success
  final paths = args;
  if (paths.isEmpty) {
    print('Invalid file path. Please provide absolute path');
    exitCode = 1;
  } else {
    final js = File(paths[0]).readAsStringSync();
    final spec =
        Specification.fromJson(json.decode(js) as Map<String, dynamic>);

    codegen.generateFiles(spec);
  }
}
