This package helps us to achieve navigation/routing for the app with capabilities like navigate between screens, construct hierarchy/tree of routes, navigate using a URL, handle deep links, and a number of other navigation-related scenarios.

## Features

This package provides the following features:
1. Construct hierarchy/tree of routes
2. Navigate between routes using absolute and relative paths
3. Handle deep links
4. URL based navigation
5. Setup initial route path
6. Send route configuration to analytics
7. Unkown route exception handler
8. Pass data between routes via path param, query param and custom object

## Getting started

Add below lines under dependencies and dependency_overrides of pubspec.yaml file

```dart
tcs_dff_route:
    path: ../../packages/tcs_dff_route
```

## Usage

1. On passing [featureMap] in the `Map<String, FeatureConfig>` format which will return a list of hierarchy/tree of routes

```dart
List<BaseRouteConfig> buildRoutes(
  final Map<String, FeatureConfig> featureMap,
)
```

2. Show all route hierarchies on console by providing [routes]

```dart
String showRouteHierarchies(final List<BaseRouteConfig> routes)
```

3. On passing [routes] and [routeHierarchies] which received from above [showRouteHierarchies] method will return map of all relative paths and it's corresponding absolute paths

```dart
Map<String, String> buildRelativeAbsolutePathMap(
  final List<BaseRouteConfig> routes,
  final String routeHierarchies,
)
```

4. [PageRouter] is used to initialize [routes] which received from above [buildRoutes] method, convert relative to absolute path by assigning above [relativeToAbsolutePath] to [redirect], handle unkown route using [onUnkownRouteException]

```dart
PageRouter({
    required this.routes,
    required this.redirect,
    required this.onUnkownRouteException,
  })
```

5. [RouteContent] is used to define as feature's route by providing [routePath] (name of the route), [content] (middle content for the route), [routes] (any further sub routes) with optional [parentNavigatorKey] (define how this route would open either from root or from immediate parent)

```dart
RouteContent({
    required this.routePath,
    required this.content,
    this.routes = const [],
    this.parentNavigatorKey,
  })
```

6. [RoutePage] is used to define how each feature's landing screen and it's below routes would render on device by providing [page] (wrapped feature's landing content along with app bar), [routes] (assigned feature's route) with optional [parentNavigatorKey] (define how this route would open either from root or from immediate parent)

```dart
RoutePage({
    required this.page,
    required this.routes,
    this.parentNavigatorKey,
  })
```

7. Push to a [location] (accept relative or absolute path) onto the navigation stack by providing [context] with optional [extra] (pass any type of data between routes)

```dart
static void push(
    final BuildContext context,
    final String location, {
    final Object? extra,
  })
```

8. Pop the top page off the navigation stack by providing [context] with optional [result] (pass any type of data back to previous route)

```dart
static void pop(
    final BuildContext context, [
    final Object? result,
  ])
```

9. Check whether any route present in navigation stack by providing [context]

```dart
static bool canPop(final BuildContext context)
```

10. Get current route path by providing [context] at any feature level

```dart
String getCurrentRoutePath(final BuildContext context)
```

## Additional information

Follow below steps to use deeplink for the app:

Android - https://docs.flutter.dev/cookbook/navigation/set-up-app-links

⁠IOS - https://docs.flutter.dev/cookbook/navigation/set-up-universal-links
