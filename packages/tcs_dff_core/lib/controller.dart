import 'dart:async';

import 'package:tcs_dff_types/config.dart';
import 'package:tcs_dff_types/tcs_dff_types.dart' as types;

import 'app_builder.dart';
import 'core_platform.dart';

Future<void> execute({
  required final types.PluginAggregator plugins,
  required final List<FeatureConfig> featureList,
  required final String initialRoutePath,
  required final UIConfig uiConfig,
}) async {
  // initialize analytics first to ensure any exception while init other plugin
  // can be captured
  await plugins.analyticsPlugin.init();
  types.dff = defaultPlatform(plugins: plugins);

  launchApp(
    featureList: featureList,
    initialRoutePath: initialRoutePath,
    uiConfig: uiConfig,
  );
}
