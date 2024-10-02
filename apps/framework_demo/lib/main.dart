import 'dart:io';

import 'package:analytics/analytics/firebase_options.dart';
import 'package:analytics/analytics_main.dart' as analytics;
import 'package:data_pass/data_pass_main.dart' as data_pass;
import 'package:demo_cipher/demo_cipher_main.dart' as cipher;
import 'package:demo_di/demo_di_main.dart' as di;
import 'package:device_features/device_features_main.dart' as device_features;
import 'package:flutter/material.dart';
import 'package:home/home_main.dart' as home;
import 'package:network/http_service/default_network_configuration.dart';
import 'package:network/http_service/http_network_overrides.dart';
import 'package:network/network_main.dart' as network;
import 'package:security/security_main.dart' as security_features;
import 'package:shared/interceptor/network_interceptor.dart';
import 'package:shared/localization/localization_config.dart';
import 'package:shared/notification.dart';
import 'package:storage/storage_main.dart' as storage;
import 'package:tcs_dff_analytics/tcs_dff_analytics.dart';
import 'package:tcs_dff_cms/tcs_dff_cms.dart';
import 'package:tcs_dff_core/tcs_dff_core.dart' as dff;
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_device_feature/tcs_dff_device_system.dart';
import 'package:tcs_dff_di/tcs_dff_di.dart';
import 'package:tcs_dff_feature_flag/tcs_dff_feature_flag.dart';
import 'package:tcs_dff_network/tcs_dff_network.dart';
import 'package:tcs_dff_storage/tcs_dff_storage.dart';
import 'package:tcs_dff_types/config.dart';
import 'package:tcs_dff_types/plugin/plugin_aggregator.dart';
import 'package:uikit/uikit_main.dart' as uikit;

late final PluginAggregator plugins;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = HttpNetworkOverrides();
  final plugins = PluginAggregator(
    dependencyInjectionPlugin: GetItDI(),
    analyticsPlugin: FirebaseAnalyticsPlugin(
      currentFirebaseOptions: DefaultFirebaseOptions.firebaseOptions,
    ),
    storagePlugin: HiveStoragePlugin(),
    networkPlugin: HttpNetworkPlugin(
      networkConfiguration: DefaultNetworkConfiguration.networkConfiguration,
      interceptor: NetworkInterceptor(),
    ),
    crashlyticsPlugin: FirebaseCrashlyticsPlugin(
      currentFirebaseOptions: DefaultFirebaseOptions.firebaseOptions,
    ),
    sharedPreferences: SharedPreferenceStorage(),
    notificationPlugin: FirebaseNotificationPlugin(
      currentFirebaseOptions: DefaultFirebaseOptions.firebaseOptions,
      initNotificationHandlers: initNotificationHandlers,
    ),
    featureFlagPlugin: FirebaseRemotePlugin(
      currentFirebaseOptions: DefaultFirebaseOptions.firebaseOptions,
      fetchTimeOut: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ),
    cmsPlugin: LiferayCMSPlugin(
      dataset: '',
      projectId: '',
      token: '',
    ),
  );

  final features = [
    network.featureConfig,
    di.featureConfig,
    home.featureConfig,
    analytics.featureConfig,
    storage.featureConfig,
    device_features.featureConfig,
    uikit.featureConfig,
    cipher.featureConfig,
    security_features.featureConfig,
    data_pass.featureConfig,
  ];

  dff.execute(
    plugins: plugins,
    featureList: features,
    initialRoutePath: '/home',
    uiConfig: UIConfig(
      themeConfig: ThemeConfig(
        themeData: AppTheme.appTheme,
      ),
      localeConfig: getLocaleConfig(),
    ),
  );
}
