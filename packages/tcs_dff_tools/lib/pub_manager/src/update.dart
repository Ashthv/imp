import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

import 'util.dart';

void runUpdateCommand(final Directory dir, final File globalPubspec) {
  final pubspecConfig = globalPubspec.readAsStringSync();
  final pubspecConfigMap = loadYaml(pubspecConfig) as YamlMap;
  final environmentConfigMap = pubspecConfigMap['environment'] as YamlMap?;
  final dependenciesConfigMap = pubspecConfigMap['dependencies'] as YamlMap?;
  final devDependenciesConfigMap =
      pubspecConfigMap['dev_dependencies'] as YamlMap?;
  final devDependenciesConfigOverideMap =
      pubspecConfigMap['dependency_overrides'] as YamlMap?;
  final nameConfig = pubspecConfigMap['name'] as String?;
  final descriptionConfig = pubspecConfigMap['description'] as String?;
  final versionConfig = pubspecConfigMap['version'] as String?;
  final homeConfig = pubspecConfigMap['homepage'] as String?;
  final publishTo = pubspecConfigMap['publish_to'] as String?;

  final pubspecFiles = _findPubspecFiles(dir);
  for (final pubspecFile in pubspecFiles) {
    final pubspecYaml = pubspecFile.readAsStringSync();
    final pubspecMap = Map.from(loadYaml(pubspecYaml) as YamlMap);
    if (environmentConfigMap != null && pubspecMap['environment'] != null) {
      final environmentToUpdate =
          Map.from(pubspecMap['environment'] as YamlMap);
      _updateDependencySection(environmentToUpdate, environmentConfigMap);
      pubspecMap['environment'] = environmentToUpdate;
    }
    if (dependenciesConfigMap != null && pubspecMap['dependencies'] != null) {
      final dependencyToUpdate =
          Map.from(pubspecMap['dependencies'] as YamlMap);
      _updateDependencySection(dependencyToUpdate, dependenciesConfigMap);
      pubspecMap['dependencies'] = dependencyToUpdate;
    }

    if (devDependenciesConfigMap != null &&
        pubspecMap['dev_dependencies'] != null) {
      final devDependencyToUpdate =
          Map.from(pubspecMap['dev_dependencies'] as YamlMap);
      _updateDependencySection(devDependencyToUpdate, devDependenciesConfigMap);
      pubspecMap['dev_dependencies'] = devDependencyToUpdate;
    }
    if (devDependenciesConfigOverideMap != null &&
        pubspecMap['dependency_overrides'] != null) {
      final devDependenciesOverideUpdate =
          Map.from(pubspecMap['dependency_overrides'] as YamlMap);
      _updateDependencySection(
        devDependenciesOverideUpdate,
        devDependenciesConfigOverideMap,
      );
      pubspecMap['dependency_overrides'] = devDependenciesOverideUpdate;
    }

    if (nameConfig != null) {
      pubspecMap['name'] = nameConfig;
    }

    if (descriptionConfig != null) {
      pubspecMap['description'] = descriptionConfig;
    }

    if (versionConfig != null) {
      pubspecMap['version'] = versionConfig;
    }

    if (homeConfig != null) {
      pubspecMap['homepage'] = homeConfig;
    }
    if (publishTo != null) {
      pubspecMap['publish_to'] = publishTo;
    }

    final yaml = dumpYaml(pubspecMap);
    pubspecFile.writeAsStringSync(yaml);

    print('Dependencies updated in ${pubspecFile.path}');
  }
}

void _updateDependencySection(
  final Map<dynamic, dynamic> dependencies,
  final YamlMap? globalDependencies,
) {
  for (final entry in globalDependencies!.entries) {
    if (dependencies.containsKey(entry.key)) {
      dependencies[entry.key as String] = entry.value;
    }
  }
}

List<File> _findPubspecFiles(final Directory directory) {
  final pubspecFiles = <File>[];
  for (final entity in directory.listSync(recursive: true)) {
    if (entity is File && path.basename(entity.path) == 'pubspec.yaml') {
      pubspecFiles.add(entity);
    }
  }
  return pubspecFiles;
}
