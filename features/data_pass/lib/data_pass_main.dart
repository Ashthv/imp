import 'package:flutter/widgets.dart';
import 'package:tcs_dff_route/tcs_dff_route.dart';
import 'package:tcs_dff_types/config.dart';
import 'package:tcs_dff_types/platform.dart';

import 'model/customer_info.dart';
import 'store/data_pass_store.dart';
import 'view/data_pass_app_bar.dart';
import 'view/data_pass_landing_screen.dart';
import 'view/data_pass_via_route_screen.dart';
import 'view/data_pass_via_store_screen.dart';

enum DataPassRoute { dataPass, store, route }

FeatureConfig featureConfig = FeatureConfig(
  name: DataPassRoute.dataPass.name,
  content: (final _, final __) {
    setupDiForDataPass();
    return const DataPassLandingScreen();
  },
  routes: _routes,
  appBar: (final routePath) {
    final dataPassRoute = DataPassRoute.values.byName(routePath);

    final appBar = switch (dataPassRoute) {
      _ => DataPassAppBar(dataPassRoute, backHandler),
    };

    return appBar;
  },
  backButtonHandler: backHandler,
);

bool backHandler(final String routePath, final BuildContext context) {
  final dataPassRoute = DataPassRoute.values.byName(routePath);

  return switch (dataPassRoute) {
    DataPassRoute.store => false,
    _ => false,
  };
}

final _routes = [
  RouteContent(
    routePath: DataPassRoute.store.name,
    content: (final _, final __) => const DataPassViaStoreScreen(),
  ),
  RouteContent(
    routePath: DataPassRoute.route.name,
    content: (final _, final state) =>
        DataPassViaRouteScreen(extra: state.extra as CustomerInfo?),
  ),
];

void setupDiForDataPass() {
  if (!dff.di.isRegistered<DataPassStore>(instanceName: 'DataPassStore')) {
    dff.di.registerSingleton<DataPassStore>(
      model: DataPassStore(),
      instanceName: 'DataPassStore',
    );
  }
}
