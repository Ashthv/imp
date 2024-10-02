import 'package:mobx/mobx.dart';

import '../model/customer_info.dart';

part 'data_pass_store.g.dart';

class DataPassStore = DataPassStoreBase with _$DataPassStore;

abstract class DataPassStoreBase with Store {
  @observable
  CustomerInfo? customerInfo;

  @action
  void updateCustomerInfo(final CustomerInfo value) {
    customerInfo = value;
  }
}
