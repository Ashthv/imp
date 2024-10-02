import 'package:tcs_dff_design_system/uikit/container/app_bar/default_app_bar.dart';
import 'package:tcs_dff_types/config.dart';

import 'view/http_home_screen.dart';

FeatureConfig featureConfig = FeatureConfig(
  name: 'network',
  content: (final _, final __) => const HttpHomeScreen(),
  appBar: (final routePath) => const DefaultAppBar(
    title: 'Network',
  ),
);
