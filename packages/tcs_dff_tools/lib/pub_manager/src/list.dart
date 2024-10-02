import 'dart:io';

import 'package:yaml/yaml.dart';

import 'util.dart';

void runListCommand(final Directory rootDir) {
  final dependenciesMap = collectDependencies(rootDir);
  File('${rootDir.path}pubspec_collection.yaml')
      .writeAsStringSync(dumpYaml(dependenciesMap));
}

Map<String, Map<String, dynamic>> collectDependencies(final Directory dir) {
  final dependenciesMap = <String, Map<String, dynamic>>{};

  final pubspecFile = File('${dir.path}/pubspec.yaml');
  if (pubspecFile.existsSync()) {
    final pubspecMap = loadYaml(pubspecFile.readAsStringSync()) as YamlMap;

    void addDependencies(final String type, final YamlMap? deps) {
      if (deps != null) {
        dependenciesMap[type] ??= {};
        deps.forEach((final key, final value) {
          dependenciesMap[type]![key as String] = value;
        });
      }
    }

    addDependencies(
      'environment',
      pubspecMap['environment'] as YamlMap?,
    );
    addDependencies(
      'dependencies',
      pubspecMap['dependencies'] as YamlMap?,
    );
    addDependencies(
      'dev_dependencies',
      pubspecMap['dev_dependencies'] as YamlMap?,
    );
    addDependencies(
      'dependency_overrides',
      pubspecMap['dependency_overrides'] as YamlMap?,
    );
  }

  for (final entity in dir.listSync()) {
    if (entity is Directory) {
      collectDependencies(entity).forEach((final type, final dependencies) {
        dependenciesMap[type] ??= {};
        dependenciesMap[type]!.addAll(dependencies);
      });
    }
  }

  return dependenciesMap;
}
