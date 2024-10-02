import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'engine/generate.dart' as codegen;
import 'specification/specification.dart';

void main(final List<String> args) {
  exitCode = 0; // 0 means success
  final parser = ArgParser()..addFlag('path', negatable: false, abbr: 'n');

  final argResults = parser.parse(args);
  final paths = argResults.rest;
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
