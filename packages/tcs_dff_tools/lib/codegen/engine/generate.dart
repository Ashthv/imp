import 'dart:io';
import '../specification/specification.dart';
import '../template/api_code.dart';
import '../template/store_code.dart';
import '../template/view_code.dart';
import '../util/util.dart';

bool generateFiles(final Specification spec) {
  String featureFolderPath;
  if (spec.featureSpec.outputPath.endsWith('/')) {
    featureFolderPath =
        '${spec.featureSpec.outputPath}${spec.featureSpec.featureName}/';
  } else {
    featureFolderPath =
        '${spec.featureSpec.outputPath}/${spec.featureSpec.featureName}/';
  }
  print('Parent directory $featureFolderPath');
  _generateViewFile(spec.viewSpec, featureFolderPath);
  _generateAPIFile(spec.apiSpec, featureFolderPath);
  _generateStoreFile(spec.storeSpec, featureFolderPath);

  return true;
}

void _generateViewFile(
  final ViewSpec? viewSpec,
  final String featureFolderPath,
) {
  if (viewSpec == null) return;
  print('Generating view code');
  final viewCode = viewSpec.stateLess
      ? ViewGeneratorTmpl.generateViewStateLessClass(viewSpec)
      : ViewGeneratorTmpl.generateViewStatefullClass(viewSpec);
  const viewFolder = 'view/';
  final fileName = '${viewSpec.className.toSnakeCase()}_page.dart';

  File('$featureFolderPath$viewFolder$fileName')
    ..createSync(recursive: true)
    ..writeAsStringSync(viewCode);

  print('${viewSpec.className.toSnakeCase()}_page.dart file created');
}

void _generateAPIFile(
  final APISpec? apiSpec,
  final String featureFolderPath,
) {
  if (apiSpec == null) return;
  print('Generating api code');
  final apiCode = APIGeneratorTmpl.generateApiClass(apiSpec);
  const apiFolder = 'api/';
  final fileName = '${apiSpec.className.toSnakeCase()}_api.dart';

  File('$featureFolderPath$apiFolder$fileName')
    ..createSync(recursive: true)
    ..writeAsStringSync(apiCode);

  print('${apiSpec.className.toSnakeCase()}_api.dart file created');
}

void _generateStoreFile(
  final StoreSpec? storeSpec,
  final String featureFolderPath,
) {
  if (storeSpec == null) return;
  print('Generating store code');
  final storeCode = MobXStoreGeneratorTmpl.generateMobXStoreClass(storeSpec);
  const storeFolder = 'store/';
  final fileName = '${storeSpec.className.toSnakeCase()}_store.dart';

  File('$featureFolderPath$storeFolder$fileName')
    ..createSync(recursive: true)
    ..writeAsStringSync(storeCode);
  print('${storeSpec.className.toSnakeCase()}_store.dart file created');
}
