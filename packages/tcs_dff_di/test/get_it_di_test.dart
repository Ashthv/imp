import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:tcs_dff_di/tcs_dff_di.dart';

GetItDI diInstance = GetItDI()..init();
int constructorCounter = 0;
int disposeCounter = 0;
int errorCounter = 0;

class TestBaseClassGeneric<T> {}

class TestClassGeneric<T> implements TestBaseClassGeneric<T> {}

abstract class TestBaseClass {}

class TestClass extends TestBaseClass {
  TestClass() {
    constructorCounter++;
  }
  void dispose() {
    disposeCounter++;
  }
}

class TestClassDisposable extends TestBaseClass with Disposable {
  TestClassDisposable() {
    constructorCounter++;
  }
  void dispose() {
    disposeCounter++;
  }

  @override
  void onDispose() {
    dispose();
  }
}

class TestClass2 {}

void main() {
  setUp(() async {
    constructorCounter = 0;
    disposeCounter = 0;
    errorCounter = 0;
  });

  tearDown(() async {
    await diInstance.release();
  });

  test('register factory', () {
    constructorCounter = 0;
    diInstance.registerFactory<TestBaseClass>(factoryFunc: TestClass.new);

    final instance1 = diInstance.get<TestBaseClass>();

    expect(instance1 is TestClass, true);

    final instance2 = diInstance.get<TestBaseClass>();

    expect(diInstance.isRegistered<TestBaseClass>(), true);
    expect(diInstance.isRegistered<TestClass2>(), false);
    expect(instance1, isNot(instance2));

    expect(constructorCounter, 2);
  });

  test('register constant i.e. singleton returning the same instance', () {
    constructorCounter = 0;

    diInstance.registerSingleton<TestBaseClass>(model: TestClass());

    final instance1 = diInstance.get<TestBaseClass>();

    expect(instance1 is TestClass, true);

    final instance2 = diInstance.get<TestBaseClass>();

    expect(instance1, instance2);

    expect(constructorCounter, 1);
  });

  test('reset and singleton dispose() test', () async {
    var destructorCounter = 0;

    diInstance
      ..registerSingleton<TestBaseClass>(model: TestClass())
      ..registerSingleton<TestBaseClass>(
        model: TestClass(),
        instanceName: 'instance2',
        dispose: (final _) {
          destructorCounter++;
        },
      );

    await diInstance.release();
    expect(
      () => diInstance.get<TestClass>(),
      throwsA(const TypeMatcher<StateError>()),
    );

    expect(destructorCounter, 1);
  });

  test('register lazySingleton', () {
    constructorCounter = 0;
    diInstance.registerLazySingleton<TestBaseClass>(factoryFunc: TestClass.new);

    expect(constructorCounter, 0);

    final instance1 = diInstance.get<TestBaseClass>();

    expect(instance1 is TestClass, true);
    expect(constructorCounter, 1);

    final instance2 = diInstance.get<TestBaseClass>();

    expect(instance1, instance2);

    expect(constructorCounter, 1);
  });

  test('trying to access not registered type', () {
    expect(
      () => diInstance.get<TestClass2>(),
      throwsA(const TypeMatcher<StateError>()),
    );
  });

  test('register and get factory by Name', () {
    constructorCounter = 0;
    diInstance.registerFactory(
      factoryFunc: TestClass.new,
      instanceName: 'FactoryByName',
    );

    final instance1 = diInstance.get<TestClass>(instanceName: 'FactoryByName');

    final instance2 = diInstance.get<TestClass>(instanceName: 'FactoryByName');

    expect(instance1, isNot(instance2));

    expect(constructorCounter, 2);
  });

  test('register constant i.e. Singleton by name', () {
    constructorCounter = 0;

    diInstance.registerSingleton(
      model: TestClass(),
      instanceName: 'ConstantByName',
    );

    final instance1 = diInstance.get<TestClass>(instanceName: 'ConstantByName');

    final instance2 = diInstance.get<TestClass>(instanceName: 'ConstantByName');

    expect(instance1, instance2);

    expect(constructorCounter, 1);
  });

  test('register lazySingleton by name', () {
    constructorCounter = 0;
    diInstance.registerLazySingleton<TestBaseClass>(
      factoryFunc: TestClass.new,
      instanceName: 'LazyByName',
    );

    expect(constructorCounter, 0);

    final instance1 = diInstance.get<TestBaseClass>(instanceName: 'LazyByName');

    expect(instance1 is TestClass, true);
    expect(constructorCounter, 1);

    final instance2 = diInstance.get<TestBaseClass>(instanceName: 'LazyByName');

    expect(instance1, instance2);

    expect(constructorCounter, 1);
  });

  test('trying to access not registered type by name', () {
    expect(
      () => diInstance.get(instanceName: 'not there'),
      throwsA(const TypeMatcher<AssertionError>()),
    );
  });

  test('GenericType test', () {
    diInstance.registerSingleton<TestBaseClassGeneric<TestBaseClass>>(
      model: TestClassGeneric<TestBaseClass>(),
    );

    final instance1 = diInstance.get<TestBaseClassGeneric<TestBaseClass>>();

    expect(instance1 is TestClassGeneric<TestBaseClass>, true);
  });

  test('unregister by instance without disposing function', () async {
    disposeCounter = 0;
    constructorCounter = 0;

    diInstance.registerSingleton<TestClass>(model: TestClass());

    final instance1 = diInstance.get<TestClass>();

    final instance2 = diInstance.get<TestClass>();

    expect(instance1, instance2);

    expect(constructorCounter, 1);

    diInstance.unregister(instance: instance2);

    expect(disposeCounter, 0);

    expect(
      () => diInstance.get<TestClass>(),
      throwsA(const TypeMatcher<StateError>()),
    );
  });

  test('unregister by type without disposing function', () async {
    disposeCounter = 0;
    constructorCounter = 0;

    diInstance.registerSingleton<TestClass>(model: TestClass());

    final instance1 = diInstance.get<TestClass>();

    final instance2 = diInstance.get<TestClass>();

    expect(instance1, instance2);

    expect(constructorCounter, 1);

    diInstance.unregister<TestClass>();

    expect(disposeCounter, 0);

    expect(
      () => diInstance.get<TestClass>(),
      throwsA(const TypeMatcher<StateError>()),
    );
  });

  test('unregister by name without disposing ', () async {
    disposeCounter = 0;
    constructorCounter = 0;

    diInstance
      ..registerSingleton(
        model: TestClass(),
        instanceName: 'instanceName',
      )
      ..unregister<TestClass>(instanceName: 'instanceName');

    expect(disposeCounter, 0);

    expect(
      () => diInstance.get<TestClass>(instanceName: 'instanceName'),
      throwsA(const TypeMatcher<StateError>()),
    );
  });

  test('unregister by instance when the dispose of the register is a future',
      () async {
    disposeCounter = 0;
    constructorCounter = 0;

    diInstance.registerSingleton<TestClass>(
      model: TestClass(),
      dispose: (final dynamic testClass) async {
        if (testClass is TestClass) {
          await Future(testClass.dispose);
        }
      },
    );

    final instance1 = diInstance.get<TestClass>();

    final instance2 = diInstance.get<TestClass>();

    expect(instance1, instance2);

    expect(constructorCounter, 1);

    await diInstance.unregister(instance: instance2);

    expect(disposeCounter, 1);

    expect(
      () => diInstance.get<TestClass>(),
      throwsA(const TypeMatcher<StateError>()),
    );
  });

  test(
      'unregister by instance when the dispose of the register is not a future',
      () async {
    disposeCounter = 0;
    constructorCounter = 0;

    diInstance.registerSingleton<TestClass>(
      model: TestClass(),
      dispose: (final dynamic testClass) {
        if (testClass is TestClass) {
          testClass.dispose();
        }
      },
    );

    final instance1 = diInstance.get<TestClass>();

    final instance2 = diInstance.get<TestClass>();

    expect(instance1, instance2);

    expect(constructorCounter, 1);

    diInstance.unregister(instance: instance2);

    expect(disposeCounter, 1);

    expect(
      () => diInstance.get<TestClass>(),
      throwsA(const TypeMatcher<StateError>()),
    );
  });

  test('unregister by instance when the disposing function is not a future',
      () async {
    disposeCounter = 0;
    constructorCounter = 0;

    diInstance.registerSingleton<TestClass>(model: TestClass());

    final instance1 = diInstance.get<TestClass>();

    final instance2 = diInstance.get<TestClass>();

    expect(instance1, instance2);

    expect(constructorCounter, 1);

    diInstance.unregister(
      instance: instance2,
      disposingFunction: (final dynamic testClass) {
        if (testClass is TestClass) {
          testClass.dispose();
        }
      },
    );

    expect(disposeCounter, 1);

    expect(
      () => diInstance.get<TestClass>(),
      throwsA(const TypeMatcher<StateError>()),
    );
  });

  test('unregister by instance when the disposing function is a future',
      () async {
    disposeCounter = 0;
    constructorCounter = 0;

    diInstance.registerSingleton<TestClass>(model: TestClass());

    final instance1 = diInstance.get<TestClass>();

    final instance2 = diInstance.get<TestClass>();

    expect(instance1, instance2);

    expect(constructorCounter, 1);

    await diInstance.unregister(
      instance: instance2,
      disposingFunction: (final dynamic testClass) async {
        if (testClass is TestClass) {
          await Future(testClass.dispose);
        }
      },
    );

    expect(disposeCounter, 1);

    expect(
      () => diInstance.get<TestClass>(),
      throwsA(const TypeMatcher<StateError>()),
    );
  });

  test('unregister by type', () async {
    disposeCounter = 0;
    constructorCounter = 0;

    diInstance.registerSingleton<TestClass>(model: TestClass());

    final instance1 = diInstance.get<TestClass>();

    final instance2 = diInstance.get<TestClass>();

    expect(instance1, instance2);

    expect(constructorCounter, 1);

    diInstance.unregister<TestClass>(
      disposingFunction: (final testClass) {
        testClass.dispose();
      },
    );

    expect(disposeCounter, 1);

    expect(
      () => diInstance.get<TestClass>(),
      throwsA(const TypeMatcher<StateError>()),
    );
  });

  test('unregister by name', () async {
    disposeCounter = 0;
    constructorCounter = 0;

    diInstance
      ..registerSingleton(
        model: TestClass(),
        instanceName: 'instanceName',
      )
      ..registerSingleton(
        model: TestClass(),
        instanceName: 'instanceName2',
      )
      ..registerSingleton(
        model: TestClass2(),
        instanceName: 'instanceName',
      )
      ..unregister<TestClass>(
        instanceName: 'instanceName',
        disposingFunction: (final testClass) {
          testClass.dispose();
        },
      );

    expect(disposeCounter, 1);

    expect(
      () => diInstance.get<TestClass>(instanceName: 'instanceName'),
      throwsA(const TypeMatcher<StateError>()),
    );
    expect(
      diInstance.get<TestClass>(instanceName: 'instanceName2'),
      const TypeMatcher<TestClass>(),
    );
    expect(
      diInstance.get<TestClass2>(instanceName: 'instanceName'),
      const TypeMatcher<TestClass2>(),
    );
  });

  test('reset LazySingleton by instance only', () {
    // Arrange
    constructorCounter = 0;
    diInstance.registerLazySingleton<TestClass>(factoryFunc: TestClass.new);
    final instance1 = diInstance.get<TestClass>();

    // Act
    diInstance.resetLazySingleton(instance: instance1);

    // Assert
    final instance2 = diInstance.get<TestClass>();
    expect(instance1, isNot(instance2));
    expect(constructorCounter, 2);
  });

  test(
      // ignore: lines_longer_than_80_chars
      'unregister by type without disposing function function but with implementing Disposable',
      () async {
    disposeCounter = 0;
    constructorCounter = 0;

    diInstance.registerSingleton<TestClassDisposable>(
      model: TestClassDisposable(),
    );

    final instance1 = diInstance.get<TestClassDisposable>();

    final instance2 = diInstance.get<TestClassDisposable>();

    expect(instance1, instance2);

    expect(constructorCounter, 1);

    diInstance.unregister<TestClassDisposable>();

    expect(disposeCounter, 1);

    expect(
      () => diInstance.get<TestClassDisposable>(),
      throwsA(const TypeMatcher<StateError>()),
    );
  });
}
