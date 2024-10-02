import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/progress_bar.dart';

class ProgressBarScreen extends StatelessWidget {
  const ProgressBarScreen({super.key});

  @override
  Widget build(final BuildContext context) => ProgressBar(
        currentRoutePath: 'factory',
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
              'analytics',
              'crashlytics',
            ],
          ),
        ],
      );
}
