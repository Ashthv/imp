import '../tcs_dff_types.dart';

class PluginAggregator {
  final AnalyticsPlugin analyticsPlugin;
  final DependencyInjectionPlugin dependencyInjectionPlugin;
  final StoragePlugin storagePlugin;
  final NetworkPlugin networkPlugin;
  final CrashlyticsPlugin crashlyticsPlugin;
  final SharedPreferencePlugin sharedPreferences;
  final NotificationPlugin notificationPlugin;
  final FeatureFlagPlugin featureFlagPlugin;
  final CMSPlugin? cmsPlugin;

  PluginAggregator({
    required this.analyticsPlugin,
    required this.dependencyInjectionPlugin,
    required this.storagePlugin,
    required this.networkPlugin,
    required this.crashlyticsPlugin,
    required this.sharedPreferences,
    required this.notificationPlugin,
    required this.featureFlagPlugin,
    this.cmsPlugin,
  });
}
