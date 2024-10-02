import '../specification/specification.dart';

class APIGeneratorTmpl {
  static String generateApiClass(final APISpec apiSpec) => '''
import 'package:shared/environment/environment.dart';
import 'package:tcs_dff_types/config.dart';
import 'package:tcs_dff_types/platform.dart';

class ${apiSpec.className}API {
  DffPlatform dffPlatform;
  ${apiSpec.className}API({required this.dffPlatform});
  Uri url = Uri.parse('\${Environment().env.baseURL}${apiSpec.url}'); 

  Future<${apiSpec.apiFunction.returnObject}> ${apiSpec.apiFunction.functionName}(${apiSpec.apiFunction.functionParams?.map((final param) => 'final ${param.type} ${param.name}').join(', ')}) async {
    final config = ApiConfig(
      url: url,
      body: '',
    );
    final response = await dffPlatform.network.auth.post(apiConfig: config);
    return ${apiSpec.apiFunction.returnObject}.fromJson(response.body as Map<String, dynamic>);
  }
}
''';
}
