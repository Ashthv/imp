library tcs_dff_di;

import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:tcs_dff_types/plugin/dependency_injection_plugin.dart';
export 'package:tcs_dff_di/tcs_dff_di.dart';

class GetItDI implements DependencyInjectionPlugin {
  late final GetIt _instance;

  @override
  T get<T extends Object>({final String? instanceName}) =>
      _instance.get<T>(instanceName: instanceName);

  @override
  void registerFactory<T extends Object>({
    required final T Function() factoryFunc,
    final String? instanceName,
    final FutureOr<dynamic> Function(T)? dispose,
  }) {
    _instance.registerFactory<T>(factoryFunc, instanceName: instanceName);
  }

  @override
  void registerLazySingleton<T extends Object>({
    required final T Function() factoryFunc,
    final String? instanceName,
    final FutureOr<dynamic> Function(T)? dispose,
  }) {
    _instance.registerLazySingleton<T>(
      factoryFunc,
      instanceName: instanceName,
      dispose: dispose,
    );
  }

  @override
  T registerSingleton<T extends Object>({
    required final T model,
    final String? instanceName,
    final bool? isReady,
    final FutureOr<dynamic> Function(T)? dispose,
  }) {
    _instance.registerSingleton<T>(
      model,
      instanceName: instanceName,
      dispose: dispose,
    );
    return model;
  }

  @override
  Future<void> init() async {
    _instance = GetIt.I;
  }

  @override
  Future<void> release() async {
    await _instance.reset();
  }

  /// Clears the instance of a lazy singleton, being able to call the factory
  /// function on the next call of 'dff.di.get' on that type again.
  /// Passing proper getit's dependency object into 'instance' param
  /// or dependency's Type inside <T> is mandatory. If dependency is registered
  /// with instancename, then pass Type inside <T> and registered instance name
  /// into 'instanceName' param.
  @override
  FutureOr resetLazySingleton<T extends Object>({
    final T? instance,
    final String? instanceName,
    final FutureOr Function(T p1)? disposingFunction,
  }) {
    _instance.resetLazySingleton<T>(
      instance: instance,
      instanceName: instanceName,
      disposingFunction: disposingFunction,
    );
  }

  @override
  bool isRegistered<T extends Object>({
    final Object? instance,
    final String? instanceName,
  }) =>
      _instance.isRegistered<T>(instance: instance, instanceName: instanceName);

  @override
  FutureOr<dynamic> unregister<T extends Object>({
    final Object? instance,
    final String? instanceName,
    final void Function(T p1)? disposingFunction,
  }) =>
      _instance.unregister<T>(
        instance: instance,
        instanceName: instanceName,
        disposingFunction: disposingFunction,
      );
}

// replaced VM extension with Object as we might use MobX's store as VM. 