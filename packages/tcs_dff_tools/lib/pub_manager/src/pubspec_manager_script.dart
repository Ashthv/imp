import 'dart:io';
import 'list.dart';
import 'outdated.dart';
import 'update.dart';
import 'upsert.dart';

Future<void> runScript(final List<String> arguments) async {
  if (arguments.isEmpty) {
    print(
      '''
Usage: dart pubspec_manager.dart <mode> <root_dir> <yaml_file for update command only>''',
    );
    print('root dir is the root of the project');
    print('Modes:');
    print('  list - List unique dependencies');
    print(
      '  update - Update pubspec.yaml files with dependencies from JSON file',
    );
    return;
  }

  final mode = arguments[0];
  final rootDir =
      arguments.length >= 2 ? Directory(arguments[1]) : Directory.current;

  if (mode == 'list') {
    runListCommand(rootDir);
  } else if (mode == 'update' || mode == 'upsert') {
    if (arguments.length < 3) {
      print(
        'Error: JSON file path is required for update or upsert mode',
      );
      return;
    }

    final jsonFile = File(arguments[2]);
    if (!jsonFile.existsSync()) {
      print('Error: JSON file "${arguments[2]}" not found');
      return;
    }
    if (mode == 'update') {
      runUpdateCommand(rootDir, jsonFile);
    } else {
      runInsertUpdateCommand(rootDir, jsonFile);
    }
  } else if (mode == 'outupgrade' || mode == 'outresolve') {
    await runFetchOutdatedCommand(rootDir, mode);
  } else {
    print('Error: Invalid mode "$mode"');
  }
}
