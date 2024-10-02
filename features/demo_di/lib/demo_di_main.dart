import 'package:tcs_dff_route/route_content.dart';
import 'package:tcs_dff_types/config.dart';
import 'package:tcs_dff_types/platform.dart';

import 'view/di_app_bar.dart';
import 'view/di_homepage_view.dart';
import 'view/factory_example_view.dart';
import 'view/lazy_app_bar.dart';
import 'view/lazy_singleton_example_view.dart';
import 'view/singleton_example_view.dart';
import 'viewmodel/factory_person_vm.dart';
import 'viewmodel/lazy_singleton_person_vm.dart';
import 'viewmodel/singleton_person_vm.dart';

enum DiRoute { di, factory, singleton, lazySingleton }

FeatureConfig featureConfig = FeatureConfig(
  name: DiRoute.di.name,
  routes: _routes,
  content: (final _, final __) {
    setUpDiForDiFeature();
    return const DIHomepageView();
  },
  appBar: (final routePath) {
    final diRoute = DiRoute.values.byName(routePath);

    final appBar = switch (diRoute) {
      DiRoute.lazySingleton => const LazyAppBar(),
      _ => DiAppBar(diRoute),
    };

    return appBar;
  },
);

final _routes = [
  RouteContent(
    routePath: DiRoute.factory.name,
    content: (final _, final __) => const FactoryExampleView(),
  ),
  RouteContent(
    routePath: DiRoute.singleton.name,
    content: (final _, final __) => const SingletonExampleView(),
  ),
  RouteContent(
    routePath: DiRoute.lazySingleton.name,
    content: (final _, final __) => const LazySingletonExampleView(),
  ),
];

void setUpDiForDiFeature() {
  dff.di.registerFactory<FactoryPersonVM>(factoryFunc: FactoryPersonVM.new);

  dff.di.registerSingleton<SingletonPersonVM>(
    model: SingletonPersonVM(),
    instanceName: 'singletonVM',
  );

  dff.di.registerLazySingleton<LazyStingletonPersonVM>(
    factoryFunc: LazyStingletonPersonVM.new,
    instanceName: 'lazySingletonVM',
  );
}
