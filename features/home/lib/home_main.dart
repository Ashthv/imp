import 'package:analytics/analytics_main.dart' as analytics;
import 'package:data_pass/data_pass_main.dart' as data_pass;
import 'package:demo_cipher/demo_cipher_main.dart' as cipher;
import 'package:demo_di/demo_di_main.dart' as di;
import 'package:device_features/device_features_main.dart' as device_features;
import 'package:feature_flag/feature_flag_main.dart' as feature_flag;
import 'package:flutter/material.dart';
import 'package:network/network_main.dart' as network;
import 'package:security/security_main.dart' as security_features;
import 'package:storage/storage_main.dart' as storage;
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_route/tcs_dff_route.dart';
import 'package:tcs_dff_types/config.dart';
import 'package:uikit/uikit_main.dart' as uikit;

import 'demo_home_page.dart';
import 'home_app_bar.dart';

FeatureConfig featureConfig = FeatureConfig(
  name: 'home',
  routes: _routes,
  content: (final _, final __) => const MyHomePage(),
  appBar: (final routePath) => const HomeAppBar(),
  transition: (final key, final child) =>
      CustomSlideLeftTransition(key: key, child: child),
  backButtonHandler: (final routePath, final context) {
    switch (routePath) {
      case 'home':
        showBottomSheetModal(
          context,
          BottomsheetTemplate(
            bottomsheetTemplateData: BottomsheetTemplateData(
              content: Container(
                child: const TextWidget(text: 'Home Sheet'),
              ),
              primaryButtonText: 'Verify',
              secondaryButtonText: 'Close',
              onPrimaryButtonTap: () {},
              onSecondaryButtonTap: () {},
              onCloseButtonTap: () {
                RouteNavigator.popDialog(context);
              },
              titleText: 'This sample OTP Screen title',
            ),
          ),
        );
        return true;
      default:
        return false;
    }
  },
);

final _routes = <RouteContent>[
  RouteContent(
    routePath: di.featureConfig.name,
    content: di.featureConfig.content,
  ),
  RouteContent(
    routePath: analytics.featureConfig.name,
    content: analytics.featureConfig.content,
  ),
  RouteContent(
    routePath: network.featureConfig.name,
    content: network.featureConfig.content,
  ),
  RouteContent(
    routePath: storage.featureConfig.name,
    content: storage.featureConfig.content,
  ),
  RouteContent(
    routePath: device_features.featureConfig.name,
    content: device_features.featureConfig.content,
  ),
  RouteContent(
    routePath: uikit.featureConfig.name,
    content: uikit.featureConfig.content,
  ),
  RouteContent(
    routePath: cipher.featureConfig.name,
    content: cipher.featureConfig.content,
  ),
  RouteContent(
    routePath: data_pass.featureConfig.name,
    content: data_pass.featureConfig.content,
  ),
  RouteContent(
    routePath: feature_flag.featureConfig.name,
    content: feature_flag.featureConfig.content,
  ),
  RouteContent(
    routePath: security_features.featureConfig.name,
    content: security_features.featureConfig.content,
  ),
];
