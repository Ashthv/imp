This package helps use to achive Dependency injection. Dependency injection is used to make a class independent of its dependencies or to create a loosely coupled program. Dependency injection is useful for improving the reusability of code. Likewise, by decoupling the usage of an object, more dependencies can be replaced without needing to change class. Current inplementation is done using the get_it package

## Getting Started

Main idea is to register dependencies in ViewModel / Controller files and access the same in UI / View files without any other complications or boilerplate code. Before you can access your objects you have to register them within our DI package typically direct in your start-up code. Refer to demo_di for more info

## Different ways of registration 
We offers different ways how objects are registered that affect the lifetime of these objects.

# Factory

```dart
void registerFactory<T extends ViewModel>({
    required final T Function() factoryFunc,
    final String? instanceName,
    final FutureOr<dynamic> Function(T)? dispose,
  });
```

You have to pass a factory function ```func```  that returns a NEW instance of an implementation of ```T```. Each time you call ```get<T>()``` you will get a new instance returned.

# Singleton & LazySingleton
Although we always would recommend using an abstract base class as a registration type so that you can vary the implementations you don't have to do this. You can also register concrete types.

```dart
T registerSingleton<T extends ViewModel>({
    required final T model,
    final String? instanceName,
    final bool? isReady,
    final FutureOr<dynamic> Function(T)? dispose,
  });
```

You have to pass an instance of ```T``` or a derived class of ```T``` that you will always get returned on a call to ```get<T>()```. The newly registered instance is also returned which can be sometimes convenient.

As creating this instance can be time-consuming at app start-up you can shift the creation to the time the object is the first time requested with:

```dart
void registerLazySingleton<T extends ViewModel>({
    required final T Function() factoryFunc,
    final String? instanceName,
    final FutureOr<dynamic> Function(T)? dispose,
  });
```

You have to pass a factory function ```func``` that returns an instance of an implementation of ```T```. Only the first time you call ```get<T>()``` this factory function will be called to create a new instance. After that, you will always get the same instance returned.

## Fetching dependencies

Simply use the ```get<T>()``` to get the reference of the desired dependency and you can access all the properties and methods of the same.

```dart
T get<T extends ViewModel>({final String? instanceName});
```

## Additional information

Some other things that can be added but currently are not:
- Scoped methods
- Parameterized factory
- Async factory
- Singleton factory
- Async Singleton
- Synchronizing async initialization of Singletons
- Unregister for all types