import 'tcs_dff_types.dart';

abstract class DffPlatform {
  final AnalyticsPlugin analytics;
  final DependencyInjectionPlugin di;
  final StoragePlugin storage;
  final NetworkPlugin network;
  final CrashlyticsPlugin crashlytics;
  final SharedPreferencePlugin sharedPreferences;
  final NotificationPlugin notification;
  final FeatureFlagPlugin featureFlag;
  final CMSPlugin? cms;

  DffPlatform({
    required this.analytics,
    required this.di,
    required this.storage,
    required this.network,
    required this.crashlytics,
    required this.sharedPreferences,
    required this.notification,
    required this.featureFlag,
    this.cms,
  });

  Future<void> initPlugins();
}

late DffPlatform dff;
