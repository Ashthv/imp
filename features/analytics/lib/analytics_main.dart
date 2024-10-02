import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_route/tcs_dff_route.dart';
import 'package:tcs_dff_types/config.dart';

import 'analytics/demo_analytics.dart';
import 'analytics_home_view.dart';
import 'crashlytics/demo_crashlytics.dart';

FeatureConfig featureConfig = FeatureConfig(
  name: 'deviceAnalytics',
  routes: _routes,
  content: (final _, final __) => const AnalyticsHomeView(),
  appBar: (final routePath) => DefaultAppBar(
    title: 'Device Analytics',
    subTitle: _getSubTitle(routePath),
  ),
  transition: (final key, final child) =>
      CustomSlideLeftTransition(key: key, child: child),
);

final _routes = [
  RouteContent(
    routePath: 'analytics',
    content: (final _, final __) => const DemoAnalytics(),
    transition: (final key, final child) =>
        CustomSlideLeftTransition(key: key, child: child),
  ),
  RouteContent(
    routePath: 'crashlytics',
    content: (final _, final __) => const DemoCrashlytics(),
    transition: (final key, final child) =>
        CustomSlideLeftTransition(key: key, child: child),
  ),
];

String? _getSubTitle(final String routePath) => switch (routePath) {
      'analytics' => 'Analytics',
      'crashlytics' => 'Crashlytics',
      _ => null,
    };
