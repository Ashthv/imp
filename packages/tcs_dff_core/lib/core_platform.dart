import 'dart:async';

import 'package:tcs_dff_types/tcs_dff_types.dart';

class _CorePlatform implements DffPlatform {
  @override
  final AnalyticsPlugin analytics;
  @override
  final DependencyInjectionPlugin di;
  @override
  final StoragePlugin storage;
  @override
  final NetworkPlugin network;
  @override
  final CrashlyticsPlugin crashlytics;
  @override
  final SharedPreferencePlugin sharedPreferences;
  @override
  final NotificationPlugin notification;
  @override
  final FeatureFlagPlugin featureFlag;
  @override
  final CMSPlugin? cms;

  _CorePlatform({
    required this.analytics,
    required this.di,
    required this.storage,
    required this.network,
    required this.crashlytics,
    required this.sharedPreferences,
    required this.notification,
    required this.featureFlag,
    this.cms,
  }) {
    initPlugins();
  }

  @override
  Future<void> initPlugins() async {
    final plugins = [
      analytics,
      di,
      storage,
      network,
      crashlytics,
      sharedPreferences,
      notification,
      featureFlag,
    ];
    final p = plugins.map(asyncInit);
    await Future.wait(p);
  }
}

Future<void> asyncInit(final Plugin p) async {
  // try {
  await p.init();
  // }
  // catch {
  //   handle plugin exception and report to analytics
  // }
}

DffPlatform defaultPlatform({
  required final PluginAggregator plugins,
}) {
  final platform = _CorePlatform(
    analytics: plugins.analyticsPlugin,
    di: plugins.dependencyInjectionPlugin,
    storage: plugins.storagePlugin,
    network: plugins.networkPlugin,
    crashlytics: plugins.crashlyticsPlugin,
    sharedPreferences: plugins.sharedPreferences,
    notification: plugins.notificationPlugin,
    featureFlag: plugins.featureFlagPlugin,
    cms: plugins.cmsPlugin,
  );

  return platform;
}
