import 'package:tcs_dff_design_system/uikit/container/app_bar/default_app_bar.dart';
import 'package:tcs_dff_route/route_content.dart';
import 'package:tcs_dff_types/config.dart';

import 'authenticity_detect/authenticity_detect_view.dart';
import 'insecure_wifi/insecure_wifi_view.dart';
import 'security_home_view.dart';
import 'vulnerable_detect/vulnerable_detect_view.dart';

FeatureConfig featureConfig = FeatureConfig(
  name: 'security',
  routes: _routes,
  content: (final _, final __) => const SecurityHomeView(),
  appBar: (final routePath) => DefaultAppBar(
    title: 'Security Features',
    subTitle: _getSubTitle(routePath),
  ),
);

final _routes = [
  RouteContent(
    routePath: 'insecure_wifi',
    content: (final _, final __) => const InsecureWifiView(),
  ),
  RouteContent(
    routePath: 'authenticity_detect',
    content: (final _, final __) => AuthenticityDetectView(),
  ),
  RouteContent(
    routePath: 'vulnerable_detect',
    content: (final _, final __) => VulnerableDetectView(),
  ),
];

String? _getSubTitle(final String routePath) => switch (routePath) {
      'insecure_wifi' => 'Insecure Wifi',
      'authenticity_detect' => 'Authenticity Detect',
      'vulnerable_detect' => 'Vulnerable Detect',
      _ => null,
    };
