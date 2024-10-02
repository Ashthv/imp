// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';
import 'util.dart';

Future<String> checkOutdatedDependencies(final String packageDir) async {
  print('Checking outdated dependencies for package: $packageDir');
  final process = await Process.start(
    'flutter',
    ['pub', 'outdated', '--json'],
    workingDirectory: packageDir,
  );

  final output = await process.stdout.transform(utf8.decoder).join();
  return output;
}

Future<List<String>> listPackages(final Directory rootDir) async {
  final process = await Process.start(
    'melos',
    ['list', '-p'],
    workingDirectory: rootDir.path,
  );

  final output = await process.stdout.transform(utf8.decoder).join();
  final packageList = output.trim().split('\n');
  return packageList;
}

Future<void> runFetchOutdatedCommand(
  final Directory rootDir,
  final String mode,
) async {
  final packages = await listPackages(rootDir);
  final packagesList = <Map<String, String>>[];
  final outdatedPackageList = [];
  final pubspecMap = <String, String>{};

  for (final packageDir in packages) {
    final outdatedDeps = await checkOutdatedDependencies(packageDir);
    final dynamic decodedJson = jsonDecode(outdatedDeps);

    if (decodedJson is Map<String, dynamic> &&
        decodedJson.containsKey('packages')) {
      final packagesJson = decodedJson['packages'] as List<dynamic>?;

      if (packagesJson != null) {
        for (final dynamic packageJson in packagesJson) {
          if (packageJson is Map<String, dynamic> &&
              packageJson['kind'] != 'transitive' &&
              !outdatedPackageList.contains(packageJson['package'] as String)) {
            final package = packageJson['package'] as String;
            final current =
                (packageJson['current']['version'] as String?) ?? '';
            final upgradable =
                (packageJson['upgradable']['version'] as String?) ?? '';
            final resolvable =
                (packageJson['resolvable']['version'] as String?) ?? '';
            final latest = (packageJson['latest']['version'] as String?) ?? '';

            packagesList.add({
              'package': package,
              'current': current,
              'upgradable': upgradable,
              'resolvable': resolvable,
              'latest': latest,
            });
            if (mode == 'outupgrade') {
              if (current != upgradable) pubspecMap[package] = upgradable;
            } else {
              if (current != resolvable) pubspecMap[package] = resolvable;
            }
            outdatedPackageList.add(package);
          }
        }
      }
    }
  }

  final jsonContent = jsonEncode(packagesList);
  final outFile = File('outdated_dependencies.json');
  await outFile.writeAsString(jsonContent);

  final outPubspec = File('outdated_dependencies_pubspec.yaml');
  await outPubspec.writeAsString(dumpYaml(pubspecMap));
}
