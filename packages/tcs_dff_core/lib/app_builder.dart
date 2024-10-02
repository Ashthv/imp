import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcs_dff_design_system/base_material_app.dart';
import 'package:tcs_dff_design_system/uikit/animation/custom_slide_left_transition.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_route/tcs_dff_route.dart';
import 'package:tcs_dff_shared_library/logger/logger.dart';
import 'package:tcs_dff_types/config.dart' as config;
import 'package:tcs_dff_types/platform.dart';

config.ApiConfig? localeApiConfig;

void launchApp({
  required final List<config.FeatureConfig> featureList,
  required final String initialRoutePath,
  required final config.UIConfig uiConfig,
}) {
  final featureConfigMap = buildMap(featureList);
  // Start Time
  final router = routeBuilder(featureConfigMap, initialRoutePath);
  // End Time
  final baseApp = AppSizer(
    builder: (final context, final orientation, final type) => baseMaterialApp(
      router: router,
      uiConfig: uiConfig,
    ),
  );

  localeApiConfig = uiConfig.localeConfig.localeApiConfig;

  runApp(baseApp);
}

@visibleForTesting
Map<String, config.FeatureConfig> buildMap(
  final List<config.FeatureConfig> featureList,
) {
  final featureMap = <String, config.FeatureConfig>{};
  for (final feature in featureList) {
    featureMap.putIfAbsent(
      feature.name,
      () => config.FeatureConfig(
        name: feature.name,
        routes: feature.routes,
        content: feature.content,
        transition: feature.transition,
        page: (final context, final state, final child) => wrappedPage(
          context: context,
          feature: feature,
          child: child,
          state: state,
          featureList: featureList,
        ),
      ),
    );
  }
  return featureMap;
}

/// Wrapped with material page or custom transition/animation page
@visibleForTesting
Page wrappedPage({
  required final BuildContext context,
  required final config.FeatureConfig feature,
  required final Widget child,
  required final RouteState state,
  required final List<config.FeatureConfig> featureList,
}) =>
    feature.transition?.call(
      state.pageKey,
      assembleFeature(context, feature, child, featureList),
    ) ??
    CustomSlideLeftTransition(
      key: state.pageKey,
      child: assembleFeature(context, feature, child, featureList),
    );

/// Assemble each feature config's app bar, content and bottom bar
@visibleForTesting
Widget assembleFeature(
  final BuildContext context,
  final config.FeatureConfig feature,
  final Widget child,
  final List<config.FeatureConfig> featureList,
) =>
    BackButtonListener(
      onBackButtonPressed: () async {
        final parent = findParent(
          RouteNavigator.getCurrentFullRoutePath(context),
          featureList,
        );
        if (parent.backButtonHandler != null) {
          return parent.backButtonHandler!.call(
            RouteNavigator.getCurrentRoutePath(context),
            rootNavigatorKey.currentContext!,
          );
        } else {
          RouteNavigator.canPop(context)
              ? RouteNavigator.pop(context)
              : SystemNavigator.pop();
          return true;
        }
      },
      child: Scaffold(
        appBar:
            feature.appBar?.call(RouteNavigator.getCurrentRoutePath(context)),
        body: child,
        bottomNavigationBar: feature.bottomBar
            ?.call(RouteNavigator.getCurrentRoutePath(context)),
      ),
    );

@visibleForTesting
config.FeatureConfig findParent(
  final String fullpath,
  final List<config.FeatureConfig> featureList,
) {
  final routeNames = fullpath.split('/')..removeWhere((final p) => p.isEmpty);
  final matchRouteName = routeNames.reversed.firstWhere(
    (final routeName) => featureList.any(
      (final f) => f.name == routeName,
    ),
  );
  return featureList.singleWhere((final f) => f.name == matchRouteName);
}

@visibleForTesting
RouterConfig<Object> routeBuilder(
  final Map<String, config.FeatureConfig> featureMap,
  final String initialRoutePath,
) {
  final routes = buildRoutes(featureMap);

  final routeHierarchies = showRouteHierarchies(routes);

  // Build map of relative path and it's corresponding absolute path
  final relativeAbsolutePathMap =
      buildRelativeAbsolutePathMap(routes, routeHierarchies);
  RouteNavigator.setRelativeAbsolutePathMap(relativeAbsolutePathMap);

  // Log to console to show all route hierarchies
  ConsoleLogger().log(routeHierarchies);

  // Initialise Routes
  return PageRouter(
    routes: routes,
    onUnkownRouteException: (final context, final state, final router) async {
      if (state.matchedLocation == '/') {
        router.go(initialRoutePath);

        // Navigation Event is logged with analytics.
        dff.analytics.logEvent(
          eventName: 'app_launch_navigation',
          parameters: {
            'fromPath': 'Initial App Launch',
            'toPath': initialRoutePath,
            'currentPage': initialRoutePath.split('/').last,
          },
        );
        // Log to console to show initial route path
        ConsoleLogger().log('initial route path $initialRoutePath');
      } else {
        ConsoleLogger().log(
          '${state.matchedLocation} doesnt exist. Check the routes structure or typo in route path or remove prefix "/" if any',
        );
        // router.go('/unkownRoute', state.matchedLocation);
      }
    },
  );
}
