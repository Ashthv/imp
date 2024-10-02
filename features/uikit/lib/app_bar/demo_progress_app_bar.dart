import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';

class DemoProgressAppBar extends ProgressAppBar {
  final String routePath;

  const DemoProgressAppBar({
    super.key,
    required this.routePath,
    super.title = '',
    super.currentRoutePath = '',
    super.progressIndicatorConfigs = const [],
  });

  @override
  Widget build(final BuildContext context) => ProgressAppBar(
        title: 'Progress App Bar',
        currentRoutePath: routePath,
        progressIndicatorConfigs: [
          ProgressIndicatorConfig(
            routePaths: [
              'di',
              'factory',
              'singleton',
              'personal',
              'lazySingleton',
            ],
          ),
          ProgressIndicatorConfig(
            routePaths: [
              'progressAppBar',
              'status',
            ],
          ),
          ProgressIndicatorConfig(
            routePaths: [
              'analytics',
              'crashlytics',
            ],
          ),
          ProgressIndicatorConfig(
            routePaths: [],
          ),
        ],
      );
}
