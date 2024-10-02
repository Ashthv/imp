// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_pass_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DataPassStore on DataPassStoreBase, Store {
  late final _$customerInfoAtom =
      Atom(name: 'DataPassStoreBase.customerInfo', context: context);

  @override
  CustomerInfo? get customerInfo {
    _$customerInfoAtom.reportRead();
    return super.customerInfo;
  }

  @override
  set customerInfo(CustomerInfo? value) {
    _$customerInfoAtom.reportWrite(value, super.customerInfo, () {
      super.customerInfo = value;
    });
  }

  late final _$DataPassStoreBaseActionController =
      ActionController(name: 'DataPassStoreBase', context: context);

  @override
  void updateCustomerInfo(CustomerInfo value) {
    final _$actionInfo = _$DataPassStoreBaseActionController.startAction(
        name: 'DataPassStoreBase.updateCustomerInfo');
    try {
      return super.updateCustomerInfo(value);
    } finally {
      _$DataPassStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
customerInfo: ${customerInfo}
    ''';
  }
}
