import 'dart:async';
import 'plugin_types.dart';

abstract interface class DependencyInjectionPlugin implements Plugin {
  T registerSingleton<T extends Object>({
    required final T model,
    final String? instanceName,
    final bool? isReady,
    final FutureOr<dynamic> Function(T)? dispose,
  });

  void registerLazySingleton<T extends Object>({
    required final T Function() factoryFunc,
    final String? instanceName,
    final FutureOr<dynamic> Function(T)? dispose,
  });

  /// Clears the instance of a lazy singleton, being able to call the factory
  /// function on the next call of 'dff.di.get' on that type again.
  /// Passing proper getit's dependency object into 'instance' param
  /// or dependency's Type inside <T> is mandatory. If dependency is registered
  /// with instancename, then pass Type inside <T> and registered instance name
  /// into 'instanceName' param.
  FutureOr resetLazySingleton<T extends Object>({
    final T? instance,
    final String? instanceName,
    final FutureOr Function(T)? disposingFunction,
  });

  void registerFactory<T extends Object>({
    required final T Function() factoryFunc,
    final String? instanceName,
    final FutureOr<dynamic> Function(T)? dispose,
  });

  T get<T extends Object>({final String? instanceName});

  bool isRegistered<T extends Object>({
    final Object? instance,
    final String? instanceName,
  });

  FutureOr<dynamic> unregister<T extends Object>({
    final Object? instance,
    final String? instanceName,
    final void Function(T)? disposingFunction,
  });
}
