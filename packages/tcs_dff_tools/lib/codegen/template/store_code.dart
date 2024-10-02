import '../specification/specification.dart';

class MobXStoreGeneratorTmpl {
  static String generateMobXStoreClass(final StoreSpec storeSpec) => '''
import 'package:mobx/mobx.dart';

part '${storeSpec.className.toLowerCase()}_store.g.dart';

class ${storeSpec.className}Store = ${storeSpec.className}StoreBase with _\$${storeSpec.className}Store;

abstract class ${storeSpec.className}StoreBase with Store {
  
  ${storeSpec.className}StoreBase({
    // inject/pass required constructor parameter for unit testing 
  });

  @observable
  ObservableFuture<${storeSpec.storeFunction.observers.map((final o) => '${o.type}>? ${o.name}Observer;').join(' ')}

  @action
  Future ${storeSpec.storeFunction.functionName}(${storeSpec.storeFunction.functionParams?.map((final param) => 'final ${param.type} ${param.name}').join(', ')}) async {
    // Replace the following code with your implementation
    final response = await api.${storeSpec.apiFunctionCall}();
    if (response != null) {
      ${storeSpec.storeFunction.observers[0].name}Observer = ObservableFuture.value(response);
    }
  }
}
''';
}
