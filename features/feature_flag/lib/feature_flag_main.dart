

import 'package:tcs_dff_design_system/uikit/container/app_bar/default_app_bar.dart';
import 'package:tcs_dff_route/tcs_dff_route.dart';
import 'package:tcs_dff_types/config.dart';

import 'firebase_remote_config_screen.dart';

FeatureConfig featureConfig = FeatureConfig(
  name: 'featureFlag',
  routes: routes,
  content: (final _, final __) =>  FirebaseRemoteConfigScreen(),
  appBar: (final routePath) => const DefaultAppBar(
    title: 'Feature Flag',
    subTitle: 'Firebase Remote Config',
  ),
);

final routes=[
   RouteContent(
    routePath: 'remote_config',
    content: (final _, final __) =>  FirebaseRemoteConfigScreen(),
  ),
];