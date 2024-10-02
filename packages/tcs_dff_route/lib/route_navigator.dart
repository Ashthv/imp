import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:tcs_dff_shared_library/logger/logger.dart';
import 'package:tcs_dff_types/platform.dart';

class RouteNavigator {
  /// Push a location onto the page stack.
  static void push(
    final BuildContext context,
    final String location, {
    final Object? extra,
  }) {
    final fromPath = RouteNavigator.getCurrentFullRoutePath(context);

    // If block executes when location match found in previous or absolute paths
    // Else block executes when location is relative path or only destination
    if (fromPath.contains(location) ||
        relativeAbsolutePathMap.containsValue(location)) {
      GoRouter.of(context).go(location, extra: extra);
    } else {
      final pushLocation =
          relativeAbsolutePathMap[location] ?? '$fromPath/$location';

      GoRouter.of(context).push(pushLocation, extra: extra);
    }

    final toPath = RouteNavigator.getCurrentFullRoutePath(context);
    dff.analytics.logEvent(
      eventName: 'forward_navigation',
      parameters: {
        'fromPath': fromPath,
        'toPath': toPath,
        'currentPage': toPath.split('/').last,
      },
    );

    // Log to console when page pushed
    ConsoleLogger().log('pushing $toPath');
  }

  /// Pop the top page off the Navigator's page stack.
  static void pop(
    final BuildContext context, [
    final Object? result,
  ]) {
    final fromPath = RouteNavigator.getCurrentFullRoutePath(context);
    GoRouter.of(context).pop(result);
    final toPath = RouteNavigator.getCurrentFullRoutePath(context);
    dff.analytics.logEvent(
      eventName: 'backward_navigation',
      parameters: {
        'fromPath': fromPath,
        'toPath': toPath,
        'currentPage': toPath.split('/').last,
      },
    );

    // Log to console when page popped
    ConsoleLogger().log('popping $fromPath');
  }

  /// Check whether any route present in navigation stack
  static bool canPop(final BuildContext context) =>
      GoRouter.of(context).canPop();

  /// Get previous route for the current route
  static String? getPreviousRoute(final BuildContext context) {
    String? previousRoute;

    final currentRoute = RouteNavigator.getCurrentFullRoutePath(context);
    final routeSegments = currentRoute.split('/')
      ..removeWhere((final p) => p.isEmpty);
    if (routeSegments.length > 1) {
      routeSegments.removeLast();
      previousRoute = '/${routeSegments.join('/')}';
    }

    return previousRoute;
  }

  /// Get next route for the current route
  static String? getNextRoute(final BuildContext context) {
    String? nextRoute;

    final currentRoute = RouteNavigator.getCurrentFullRoutePath(context);
    final matchedRoutes = relativeAbsolutePathMap.values
        .where(
          (final absoluteRoute) => absoluteRoute.startsWith(currentRoute),
        )
        .toList()
      ..removeWhere((final absoluteRoute) => absoluteRoute == currentRoute);
    if (matchedRoutes.isNotEmpty) {
      nextRoute = matchedRoutes.first;
    }

    return nextRoute;
  }

  /// Pop the dailog or bottomsheet
  static void popDialog(final BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop(context);
  }

  /// Get current route path
  /// Ex: path "/home/di/factory" below method returns "factory"
  /// Ex: path "/home/di" below method returns "di"
  static String getCurrentRoutePath(final BuildContext context) {
    final fullRoutePath = RouteNavigator.getCurrentFullRoutePath(context);
    final routePaths = fullRoutePath.split('/')
      ..removeWhere((final p) => p.isEmpty);

    return routePaths.last;
  }

  /// Get current full route path
  static String getCurrentFullRoutePath(final BuildContext context) {
    final fullRoutePath = GoRouter.of(context)
        .routerDelegate
        .currentConfiguration
        .last
        .matchedLocation;

    return fullRoutePath;
  }

  static final relativeAbsolutePathMap = <String, String>{};

  static void setRelativeAbsolutePathMap(final Map<String, String> pathMap) {
    relativeAbsolutePathMap.addAll(pathMap);
  }
}
