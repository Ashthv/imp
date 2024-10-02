import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcs_dff_design_system/uikit/animation/custom_slide_left_transition.dart';
import 'package:tcs_dff_types/config.dart';

import 'tcs_dff_route.dart';

List<BaseRouteConfig> buildRoutes(
  final Map<String, FeatureConfig> featureMap,
) {
  final routes = <BaseRouteConfig>[];

  final featureList = featureMap.values.toList();

  for (final feature in featureList) {
    // Skip iteration when route path is already formed/captured for the feature
    // Or
    // Skip iteration when feature has parent
    if (capturedRoutePaths.contains(feature.name) ||
        featureContainsParent(feature.name, featureList)) {
      continue;
    }

    routes.add(
      RoutePage(
        page: feature.page!,
        routes: [
          RouteContent(
            routePath: '/${feature.name}',
            content: feature.content,
            routes: buildSubRoutes(featureList, feature.routes),
            contentBuilder: (final context, final state) =>
                feature.transition?.call(
                  state.pageKey,
                  feature.content.call(context, state),
                ) ??
                CustomSlideLeftTransition(
                  key: state.pageKey,
                  child: feature.content.call(context, state),
                ),
          ),
        ],
      ),
    );

    /// Capture each feature config's page name
    capturedRoutePaths.add(feature.name);
  }

  return routes;
}

/// Check whether feature contains parent or not
@visibleForTesting
bool featureContainsParent(
  final String featureName,
  final List<FeatureConfig> featureList,
) {
  /// Exclude current feature from featureList to avoid uncessary iterations
  final tempFeaturelist = featureList.toList()
    ..removeWhere((final element) => element.name == featureName);

  final featureParent = tempFeaturelist.firstWhereOrNull(
    (final element) => findParentInAllRoutes(
      element.routes,
      featureName,
    ),
  );

  return featureParent != null;
}

/// Recursively check is feature has parent in
/// each feature routes and it's further sub routes
@visibleForTesting
bool findParentInAllRoutes(
  final Iterable<RouteContent> routes,
  final String featureName,
) =>
    routes.any(
      (final route) {
        if (route.routes.isEmpty) {
          return route.routePath == featureName;
        } else {
          return findParentInAllRoutes(
            route.routes.map((final e) => e as RouteContent),
            featureName,
          );
        }
      },
    );

/// Capture route paths to avoid building routes when
/// route itself is a [FeatureConfig]
@visibleForTesting
Set<String> capturedRoutePaths = {};

/// Mapping of routes and it's sub routes by matching
/// [FeatureConfig] -> name and [RouteContent] -> route
@visibleForTesting
List<BaseRouteConfig> buildSubRoutes(
  final List<FeatureConfig> featureList,
  final List<RouteContent> routes,
) =>
    routes.expand(
      (final route) {
        /// Capture each feature config's route path
        capturedRoutePaths.add(route.routePath);
        final isSubRouteAFeature = featureList.singleWhereOrNull(
          (final feature) => feature.name.trim() == route.routePath.trim(),
        );
        return [
          if (isSubRouteAFeature != null)
            RoutePage(
              parentNavigatorKey: rootNavigatorKey,
              page: isSubRouteAFeature.page!,
              routes: [
                RouteContent(
                  routePath: isSubRouteAFeature.name,
                  content: isSubRouteAFeature.content,
                  routes:
                      buildSubRoutes(featureList, isSubRouteAFeature.routes),
                  contentBuilder: (final context, final state) =>
                      isSubRouteAFeature.transition?.call(
                        state.pageKey,
                        isSubRouteAFeature.content.call(context, state),
                      ) ??
                      CustomSlideLeftTransition(
                        key: state.pageKey,
                        child: isSubRouteAFeature.content.call(context, state),
                      ),
                ),
              ],
            )
          else
            RouteContent(
              // parentNavigatorKey: rootNavigatorKey,
              routePath: route.routePath,
              content: route.content,
              routes: buildSubRoutes(
                featureList,
                route.routes.map((final e) => e as RouteContent).toList(),
              ),
              contentBuilder: (final context, final state) =>
                  route.transition?.call(
                    state.pageKey,
                    route.content.call(context, state),
                  ) ??
                  CustomSlideLeftTransition(
                    key: state.pageKey,
                    child: route.content.call(context, state),
                  ),
            ),
        ];
      },
    ).toList();

/// Build map of relative path and it's corresponding absolute path
Map<String, String> buildRelativeAbsolutePathMap(
  final List<BaseRouteConfig> routes,
  final String routeHierarchies,
) {
  final lastRoutePath = routeHierarchies.split('=>').last.trim();
  final relativeAbsolutePathMap =
      generateRelativeAndAbsolutePaths(routes, lastRoutePath, {}, '');
  return relativeAbsolutePathMap;
}

/// Recursively generate relative and absolute paths
@visibleForTesting
Map<String, String> generateRelativeAndAbsolutePaths(
  final List<BaseRouteConfig> routes,
  final String lastRoutePath,
  final Map<String, String> relativeAbsolutePathMap,
  final String parentFullpath,
) {
  for (final route in routes) {
    final fullPath = (route is RouteContent)
        ? concatenatePaths(parentFullpath, route.path)
        : parentFullpath;
    final relativePath = (route is RouteContent)
        ? getRelativePath(
            parentFullpath,
            route,
          )
        : null;
    if (relativePath != null) relativeAbsolutePathMap[relativePath] = fullPath;

    if (fullPath == lastRoutePath) {
      return relativeAbsolutePathMap;
    } else {
      generateRelativeAndAbsolutePaths(
        route.routes,
        lastRoutePath,
        relativeAbsolutePathMap,
        fullPath,
      );
    }
  }

  return relativeAbsolutePathMap;
}

/// Get relative path from parent and route
@visibleForTesting
String getRelativePath(
  final String parentFullpath,
  final RouteContent route,
) {
  final parent = parentFullpath.split('/').lastOrNull ?? '';
  final relativePath =
      parent.isNotEmpty ? '/$parent/${route.routePath}' : route.routePath;

  return relativePath;
}

/// Show all route hierarchies
String showRouteHierarchies(final List<BaseRouteConfig> routes) {
  final sb = StringBuffer()..writeln('Full paths for routes:');
  showFullPathsFor(routes, '', 0, sb);

  return sb.toString();
}

@visibleForTesting
void showFullPathsFor(
  final List<BaseRouteConfig> routes,
  final String parentFullpath,
  final int depth,
  final StringBuffer sb,
) {
  for (final route in routes) {
    if (route is RouteContent) {
      final fullPath = concatenatePaths(parentFullpath, route.path);
      sb.writeln('  => ${''.padLeft(depth * 2)}$fullPath');
      showFullPathsFor(route.routes, fullPath, depth + 1, sb);
    } else if (route is ShellRouteBase) {
      showFullPathsFor(route.routes, parentFullpath, depth, sb);
    }
  }
}

/// Concatenates two paths.
///
/// e.g: pathA = /a, pathB = c/d,  concatenatePaths(pathA, pathB) = /a/c/d.
// ignore_for_file: prefer_asserts_with_message
@visibleForTesting
String concatenatePaths(
  final String parentPath,
  final String childPath,
) {
  // at the root, just return the path
  if (parentPath.isEmpty) {
    assert(childPath.startsWith('/'));
    assert(childPath == '/' || !childPath.endsWith('/'));
    return childPath;
  }

  // not at the root, so append the parent path
  assert(childPath.isNotEmpty);
  assert(!childPath.startsWith('/'));
  assert(!childPath.endsWith('/'));
  return '${parentPath == '/' ? '' : parentPath}/$childPath';
}
