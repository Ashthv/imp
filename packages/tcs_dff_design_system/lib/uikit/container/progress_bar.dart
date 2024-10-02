import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';

class ProgressBar extends StatelessWidget {
  final String currentRoutePath;
  final List<ProgressIndicatorConfig> progressIndicatorConfigs;

  const ProgressBar({
    super.key,
    required this.currentRoutePath,
    required this.progressIndicatorConfigs,
  });

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    return Padding(
      padding: EdgeInsets.only(
        left: size.size10.dp,
        right: size.size10.dp,
        top: size.size4.dp,
        bottom: size.size8.dp,
      ),
      child: Row(
        children: List.generate(
          progressIndicatorConfigs.length,
          (final index) {
            final routePathPosititon = progressIndicatorConfigs[index]
                .routePaths
                .indexOf(currentRoutePath);

            double progressValue;

            if (routePathPosititon >= 0) {
              progressValue = (routePathPosititon + 1) /
                  progressIndicatorConfigs[index].routePaths.length;
            } else {
              final isRoutePathMatched =
                  progressIndicatorConfigs.skip(index + 1).any(
                        (final indicatorConfig) =>
                            indicatorConfig.routePaths.any(
                          (final routePath) => routePath == currentRoutePath,
                        ),
                      );

              if (isRoutePathMatched) {
                progressValue = 1.0;
              } else {
                progressValue = 0.0;
              }
            }

            return ProgressBarIndicator(value: progressValue);
          },
        ),
      ),
    );
  }
}

class ProgressBarIndicator extends StatelessWidget {
  final double value;

  const ProgressBarIndicator({super.key, required this.value});

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.size5.dp),
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: color.clrPrimaryPurple120,
          borderRadius: BorderRadius.circular(size.size4.dp),
          minHeight: size.size4.dp,
        ),
      ),
    );
  }
}

class ProgressIndicatorConfig {
  final List<String> routePaths;

  ProgressIndicatorConfig({
    required this.routePaths,
  });
}
