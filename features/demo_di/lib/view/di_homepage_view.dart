import 'package:flutter/material.dart';
import 'package:tcs_dff_route/route_navigator.dart';
import 'package:tcs_dff_types/platform.dart';
import 'package:tcs_dff_types/tcs_dff_types.dart';

import '../viewmodel/factory_person_vm.dart';
import '../viewmodel/lazy_singleton_person_vm.dart';
import '../viewmodel/singleton_person_vm.dart';

class DIHomepageView extends StatefulWidget {
  const DIHomepageView({super.key});

  @override
  State<DIHomepageView> createState() => _DIHomepageViewState();
}

class _DIHomepageViewState extends State<DIHomepageView> {
  @override
  Widget build(final BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/di/factory');
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const FactoryExampleView()),
                // );
              },
              child: const Text('Factory'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/di/singleton');
              },
              child: const Text('Singleton'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/di/lazySingleton');
              },
              child: const Text('Lazy Singleton'),
            ),
            ElevatedButton(
              onPressed: () {
                dff.di.unregister<FactoryPersonVM>();

                dff.di.registerFactory<FactoryPersonVM>(
                  factoryFunc: FactoryPersonVM.new,
                );
              },
              child: const Text('Unregister Factory'),
            ),
            ElevatedButton(
              onPressed: () {
                dff.di.unregister<SingletonPersonVM>(
                  instanceName: 'singletonVM',
                );
                dff.di.registerSingleton<SingletonPersonVM>(
                  model: SingletonPersonVM(),
                  instanceName: 'singletonVM',
                );
              },
              child: const Text('Unregister Singleton'),
            ),
            ElevatedButton(
              onPressed: () {
                dff.di.unregister<LazyStingletonPersonVM>(
                  instanceName: 'lazySingletonVM',
                );
                dff.di.registerLazySingleton<LazyStingletonPersonVM>(
                  factoryFunc: LazyStingletonPersonVM.new,
                  instanceName: 'lazySingletonVM',
                );
              },
              child: const Text('Unregister Lazy Singleton'),
            ),
            ElevatedButton(
              onPressed: () {
                // Calling resetLazySingleton() using 'instance' arg
                dff.di.resetLazySingleton(
                  instance: dff.di.get<LazyStingletonPersonVM>(
                    instanceName: 'lazySingletonVM',
                  ),
                );
                // OR you also call like below.
                // Calling resetLazySingleton using Type and 'instanceName' arg.
                // If dependency is not registered with instance name,
                // only pass Type inside <> and keep args empty.

                // dff.di.resetLazySingleton<LazyStingletonPersonVM>(
                //   instanceName: 'lazySingletonVM',
                // );
              },
              child: const Text('Reset Lazy Singleton'),
            ),
          ],
        ),
      );
  @override
  void dispose() {
    dff.di.unregister<FactoryPersonVM>();
    dff.di.unregister<SingletonPersonVM>(
      instanceName: 'singletonVM',
    );
    dff.di.unregister<LazyStingletonPersonVM>(
      instanceName: 'lazySingletonVM',
    );
    super.dispose();
  }
}
