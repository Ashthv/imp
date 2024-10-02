import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tcs_dff_core/app_builder.dart';
import 'package:tcs_dff_route/tcs_dff_route.dart';
import 'package:tcs_dff_test/dff_mocks.dart';
import 'package:tcs_dff_types/config.dart';
import 'package:tcs_dff_types/platform.dart';

final sharedFeatureList = [
  FeatureConfig(
    name: 'network',
    content: (final _, final __) =>
        const Text('Network Content', key: Key('network')),
  ),
  FeatureConfig(
    name: 'home',
    content: (final _, final __) =>
        const Text('Home Content', key: Key('home')),
    routes: [
      RouteContent(
        routePath: 'network',
        content: (final _, final __) =>
            const Text('Network Content', key: Key('network')),
      ),
      RouteContent(
        routePath: 'di',
        content: (final _, final __) =>
            const Text('Di Content', key: Key('di')),
      ),
      RouteContent(
        routePath: 'rewards',
        content: (final _, final __) =>
            const Text('Rewards Content', key: Key('rewards')),
        routes: [
          RouteContent(
            routePath: 'network',
            content: (final _, final __) =>
                const Text('Network Content', key: Key('network')),
          ),
        ],
      ),
    ],
  ),
  FeatureConfig(
    name: 'di',
    content: (final _, final __) => const Text('Di Content', key: Key('di')),
    appBar: (final routePath) =>
        AppBar(title: Text(routePath), key: const Key('diAppBar')),
    routes: [
      RouteContent(
        routePath: 'factory',
        content: (final _, final __) =>
            const Text('Factory Content', key: Key('factory')),
      ),
    ],
  ),
  FeatureConfig(
    name: 'signUp',
    content: (final _, final __) =>
        const Text('SignUp Content', key: Key('signUp')),
  ),
];

void main() {
  final featureMap = buildMap(sharedFeatureList);
  final routes = buildRoutes(featureMap);
  final routeHierarchies = showRouteHierarchies(routes);

  group('Route Builder', () {
    test('verify route hierarchies, pages and contents', () {
      // check home route type is page and path formed correctly
      final isHomeRouteTypePageAndPathCorrect = routes.any(
        (final route) =>
            route is RoutePage &&
            (route.routes.firstOrNull as RouteContent?)?.routePath == '/home',
      );
      expect(
        isHomeRouteTypePageAndPathCorrect,
        true,
        reason: 'home route type is not a page and path is incorrect',
      );

      // check network or rewards/network route type is page and path formed correctly
      final isRootNetworkRouteTypePageAndPathCorrect = routes.any(
        (final route) =>
            route is RoutePage &&
            (route.routes.first as RouteContent).routes.any(
                  (final element) =>
                      element is RoutePage &&
                      ((element.routes.firstOrNull as RouteContent?)
                              ?.routePath ==
                          'network'),
                ),
      );
      expect(
        isRootNetworkRouteTypePageAndPathCorrect,
        true,
        reason: 'root network route type is not a page and path is incorrect',
      );

      final isRewardsNetworkRouteTypePageAndPathCorrect = routes.any(
        (final route) =>
            route is RoutePage &&
            (route.routes.first as RouteContent).routes.any(
                  (final element) =>
                      element is RouteContent &&
                      element.routePath == 'rewards' &&
                      element.routes.firstOrNull is RoutePage? &&
                      ((element.routes.firstOrNull as RoutePage?)
                                  ?.routes
                                  .firstOrNull as RouteContent?)
                              ?.routePath ==
                          'network',
                ),
      );
      expect(
        isRewardsNetworkRouteTypePageAndPathCorrect,
        true,
        reason: 'rewards network route type is not a page & path is incorrect',
      );

      // check di route type is page and path formed correctly
      final isDiRouteTypePageAndPathCorrect = routes.any(
        (final route) =>
            route is RoutePage &&
            (route.routes.first as RouteContent).routes.any(
                  (final element) =>
                      element is RoutePage &&
                      ((element.routes.firstOrNull as RouteContent?)
                              ?.routePath ==
                          'di'),
                ),
      );
      expect(
        isDiRouteTypePageAndPathCorrect,
        true,
        reason: 'di route type is not a page and path is incorrect',
      );

      // check factory route type is content and path formed correctly
      final isFactoryRouteTypePageAndPathCorrect = routes.any(
        (final route) =>
            route is RoutePage &&
            (route.routes.first as RouteContent).routes.any(
                  (final element) =>
                      element is RoutePage &&
                      (((element.routes.first as RouteContent)
                                  .routes
                                  .firstOrNull as RouteContent?)
                              ?.routePath ==
                          'factory'),
                ),
      );
      expect(
        isFactoryRouteTypePageAndPathCorrect,
        true,
        reason: 'factory route type is not a content and path is incorrect',
      );

      // check rewards route type is content and path formed correctly
      final isRewardsRouteTypePageAndPathCorrect = routes.any(
        (final route) =>
            route is RoutePage &&
            (route.routes.first as RouteContent).routes.any(
                  (final element) =>
                      element is RouteContent && element.routePath == 'rewards',
                ),
      );
      expect(
        isRewardsRouteTypePageAndPathCorrect,
        true,
        reason: 'rewards route type is not a content and path is incorrect',
      );

      // check signUp route type is page and path formed correctly
      final isSignUpRouteTypePageAndPathCorrect = routes.any(
        (final route) =>
            route is RoutePage &&
            (route.routes.firstOrNull as RouteContent?)?.routePath == '/signUp',
      );
      expect(
        isSignUpRouteTypePageAndPathCorrect,
        true,
        reason: 'signUp route type is not a page and path is incorrect',
      );
    });

    test('check captured route paths', () {
      final expectedCapturedRoutePaths = {
        'network',
        'di',
        'factory',
        'rewards',
        'home',
        'signUp',
      };
      expect(
        const DeepCollectionEquality()
            .equals(capturedRoutePaths, expectedCapturedRoutePaths),
        true,
        reason: 'captured route paths doesnt match',
      );
    });

    test('build sub routes function', () {
      final homeRoutes = featureMap.values
          .firstWhere((final element) => element.name == 'home')
          .routes;
      final homeSubRoutes =
          buildSubRoutes(featureMap.values.toList(), homeRoutes);

      // check network or rewards/network route type is page and path formed correctly
      final isRootNetworkRouteTypePageAndPathCorrect = homeSubRoutes.any(
        (final route) =>
            route is RoutePage &&
            (route.routes.first as RouteContent).routePath == 'network',
      );
      expect(
        isRootNetworkRouteTypePageAndPathCorrect,
        true,
        reason: 'root network route type is not a page and path is incorrect',
      );

      final isRewardsNetworkRouteTypePageAndPathCorrect = homeSubRoutes.any(
        (final route) =>
            route is RouteContent &&
            route.routePath == 'rewards' &&
            route.routes.firstOrNull is RoutePage? &&
            ((route.routes.firstOrNull as RoutePage?)?.routes.firstOrNull
                        as RouteContent?)
                    ?.routePath ==
                'network',
      );
      expect(
        isRewardsNetworkRouteTypePageAndPathCorrect,
        true,
        reason: 'rewards network route type is not a page & path is incorrect',
      );

      // check di route type is page and path formed correctly
      final isDiRouteTypePageAndPathCorrect = homeSubRoutes.any(
        (final route) =>
            route is RoutePage &&
            (route.routes.first as RouteContent).routePath == 'di',
      );
      expect(
        isDiRouteTypePageAndPathCorrect,
        true,
        reason: 'di route type is not a page and path is incorrect',
      );

      // check factory route type is content and path formed correctly
      final isFactoryRouteTypePageAndPathCorrect = homeSubRoutes.any(
        (final route) =>
            route is RoutePage &&
            (route.routes.first as RouteContent).routes.any(
                  (final element) =>
                      element is RouteContent && element.routePath == 'factory',
                ),
      );
      expect(
        isFactoryRouteTypePageAndPathCorrect,
        true,
        reason: 'factory route type is not a content and path is incorrect',
      );

      // check rewards route type is content and path formed correctly
      final isRewardsRouteTypePageAndPathCorrect = homeSubRoutes.any(
        (final route) => route is RouteContent && route.routePath == 'rewards',
      );
      expect(
        isRewardsRouteTypePageAndPathCorrect,
        true,
        reason: 'rewards route type is not a content and path is incorrect',
      );
    });

    test('check feature contains parent', () {
      // check featureContainsParent function
      expect(
        featureContainsParent('network', featureMap.values.toList()),
        true,
        reason: 'network contains parent',
      );
      expect(
        featureContainsParent('signUp', featureMap.values.toList()),
        false,
        reason: 'signUp does not contains parent',
      );

      // check findParentInAllRoutes function
      final homeRoutes = featureMap.values
          .singleWhere((final element) => element.name == 'home')
          .routes;
      expect(
        findParentInAllRoutes(homeRoutes, 'network'),
        true,
        reason: 'network contains parent',
      );
      expect(
        findParentInAllRoutes(homeRoutes, 'signUp'),
        false,
        reason: 'signUp does not contains parent',
      );
    });

    test('check route hierarchies', () {
      // check showRouteHierarchies function
      final expectedRouteHierarchies = StringBuffer()
        ..writeln('Full paths for routes:')
        ..writeln('  => ${''.padLeft(0 * 2)}/home')
        ..writeln('  => ${''.padLeft(1 * 2)}/home/network')
        ..writeln('  => ${''.padLeft(1 * 2)}/home/di')
        ..writeln('  => ${''.padLeft(2 * 2)}/home/di/factory')
        ..writeln('  => ${''.padLeft(1 * 2)}/home/rewards')
        ..writeln('  => ${''.padLeft(2 * 2)}/home/rewards/network')
        ..writeln('  => ${''.padLeft(0 * 2)}/signUp');
      expect(
        routeHierarchies,
        expectedRouteHierarchies.toString(),
        reason: 'route hierarchy shown is incorrect',
      );

      // check showFullPathsFor function
      final showFullPathBuffer = StringBuffer()
        ..writeln('Full paths for routes:');
      showFullPathsFor(routes, '', 0, showFullPathBuffer);
      expect(
        showFullPathBuffer.toString(),
        expectedRouteHierarchies.toString(),
        reason: 'route hierarchy shown is incorrect for showFullPathsFor func',
      );
    });

    test('build map of relative path and absolute path', () {
      // check buildRelativeAbsolutePathMap function
      final expectedRelativeAbsolutePathMap = {
        '/home': '/home',
        '/home/network': '/home/network',
        '/home/di': '/home/di',
        '/di/factory': '/home/di/factory',
        '/home/rewards': '/home/rewards',
        '/rewards/network': '/home/rewards/network',
        '/signUp': '/signUp',
      };
      final relativeAbsolutePathMap =
          buildRelativeAbsolutePathMap(routes, routeHierarchies);
      expect(
        const DeepCollectionEquality()
            .equals(relativeAbsolutePathMap, expectedRelativeAbsolutePathMap),
        true,
        reason: 'map of relative path and absolute path is incorrect',
      );

      // check generateRelativeAndAbsolutePaths function
      final lastRoutePath = routeHierarchies.split('=>').last.trim();
      final generateRelativeAbsolutePathMap =
          generateRelativeAndAbsolutePaths(routes, lastRoutePath, {}, '');
      expect(
        const DeepCollectionEquality().equals(
          generateRelativeAbsolutePathMap,
          expectedRelativeAbsolutePathMap,
        ),
        true,
        reason: 'map of relative path and absolute path is incorrect',
      );

      // check getRelativePath function
      final factoryRouteContent = RouteContent(
        routePath: 'factory',
        content: (final _, final __) => const SizedBox.shrink(),
      );
      expect(
        getRelativePath('/home/di', factoryRouteContent),
        '/di/factory',
        reason: 'factory relative path is incorrect',
      );

      final signUpRouteContent = RouteContent(
        routePath: '/signUp',
        content: (final _, final __) => const SizedBox.shrink(),
      );
      expect(
        getRelativePath('', signUpRouteContent),
        '/signUp',
        reason: 'signUp relative path is incorrect',
      );
    });

    test('concatenate paths function', () {
      expect(
        concatenatePaths('/home', 'di/factory'),
        '/home/di/factory',
        reason: 'concatenated path is incorrect',
      );
    });
  });

  group('Route Navigator', () {
    setUp(() {
      dff = MockDffPlatform();
      when(
        () => dff.analytics.logEvent(
          eventName: any(named: 'eventName'),
          parameters: any(named: 'parameters'),
        ),
      ).thenAnswer((final _) => Future.value());
      RouteNavigator.relativeAbsolutePathMap.clear();
    });

    testWidgets('on push', (final WidgetTester tester) async {
      await createRouter(routes, tester);
      RouteNavigator.setRelativeAbsolutePathMap(
        buildRelativeAbsolutePathMap(routes, routeHierarchies),
      );
      final context = tester.element(find.byKey(const Key('home')));
      expect(
        GoRouter.of(context)
            .routerDelegate
            .currentConfiguration
            .last
            .matchedLocation,
        '/home',
        reason: 'before push route path is invalid',
      );
      RouteNavigator.push(context, '/home/di');
      expect(
        GoRouter.of(context)
            .routerDelegate
            .currentConfiguration
            .last
            .matchedLocation,
        '/home/di',
        reason: 'after push route path is invalid',
      );
    });

    testWidgets('on pop', (final WidgetTester tester) async {
      await createRouter(routes, tester, initialRoutePath: '/home/di');
      final context = tester.element(find.text('Di Content'));
      expect(
        GoRouter.of(context)
            .routerDelegate
            .currentConfiguration
            .last
            .matchedLocation,
        '/home/di',
        reason: 'before pop route path is invalid',
      );
      RouteNavigator.pop(context);
      expect(
        GoRouter.of(context)
            .routerDelegate
            .currentConfiguration
            .last
            .matchedLocation,
        '/home',
        reason: 'after pop route path is invalid',
      );
    });

    testWidgets('can pop', (final WidgetTester tester) async {
      await createRouter(routes, tester, initialRoutePath: '/home/di');
      final context = tester.element(find.text('Di Content'));
      expect(
        RouteNavigator.canPop(context),
        true,
        reason: 'can able to pop from di',
      );
      RouteNavigator.pop(context);
      expect(
        RouteNavigator.canPop(context),
        false,
        reason: 'cant able to pop from home',
      );
    });

    testWidgets('get current route path', (final WidgetTester tester) async {
      await createRouter(routes, tester, initialRoutePath: '/home/di');
      final context = tester.element(find.text('Di Content'));
      expect(
        RouteNavigator.getCurrentRoutePath(context),
        'di',
        reason: 'invalid current route path (di)',
      );
      RouteNavigator.pop(context);
      expect(
        RouteNavigator.getCurrentRoutePath(context),
        'home',
        reason: 'invalid current route path (home)',
      );
    });

    testWidgets('get previous route', (final WidgetTester tester) async {
      await createRouter(routes, tester, initialRoutePath: '/home/di');
      RouteNavigator.setRelativeAbsolutePathMap(
        buildRelativeAbsolutePathMap(routes, routeHierarchies),
      );
      final context = tester.element(find.text('Di Content'));
      expect(
        RouteNavigator.getPreviousRoute(context),
        '/home',
        reason: 'invalid previous route',
      );
      RouteNavigator.push(context, '/signUp');
      expect(
        RouteNavigator.getPreviousRoute(context),
        null,
        reason: 'invalid previous route',
      );
      RouteNavigator.push(context, '/home/rewards/network');
      expect(
        RouteNavigator.getPreviousRoute(context),
        '/home/rewards',
        reason: 'invalid previous route',
      );
    });

    testWidgets('get next route', (final WidgetTester tester) async {
      final relativeAbsolutePathMap = {
        '/home': '/home',
        '/home/network': '/home/network',
        '/home/di': '/home/di',
        '/di/factory': '/home/di/factory',
        '/home/rewards': '/home/rewards',
        '/rewards/network': '/home/rewards/network',
        '/signUp': '/signUp',
      };
      RouteNavigator.setRelativeAbsolutePathMap(relativeAbsolutePathMap);
      await createRouter(routes, tester, initialRoutePath: '/home/di');
      final context = tester.element(find.text('Di Content'));
      expect(
        RouteNavigator.getNextRoute(context),
        '/home/di/factory',
        reason: 'invalid next route',
      );
      RouteNavigator.push(context, '/signUp');
      expect(
        RouteNavigator.getNextRoute(context),
        null,
        reason: 'invalid next route',
      );
      RouteNavigator.push(context, '/home');
      expect(
        RouteNavigator.getNextRoute(context),
        '/home/network',
        reason: 'invalid next route',
      );
    });

    testWidgets('get current full route path',
        (final WidgetTester tester) async {
      await createRouter(routes, tester, initialRoutePath: '/home/rewards/network');
      final context = tester.element(find.text('Network Content'));
      expect(
        RouteNavigator.getCurrentFullRoutePath(context),
        '/home/rewards/network',
        reason: 'invalid current full route path (network)',
      );
      RouteNavigator.pop(context);
      expect(
        RouteNavigator.getCurrentFullRoutePath(context),
        '/home/rewards',
        reason: 'invalid current full route path (rewards)',
      );
    });

    testWidgets('pop dialog', (final WidgetTester tester) async {
      await createRouter(routes, tester, initialRoutePath: '/home/di');
      final context = tester.element(find.text('Di Content'));
      showBottomSheet(
        context: context,
        builder: (final _) => const Text('BottomSheet'),
      );
      await tester.pumpAndSettle();
      expect(
        find.text('BottomSheet'),
        findsOneWidget,
        reason: 'bottom sheet not found',
      );
      RouteNavigator.popDialog(context);
      await tester.pumpAndSettle();
      expect(
        find.text('BottomSheet'),
        findsNothing,
        reason: 'bottom sheet should be hidden',
      );
    });

    test('check relative absolute path map', () {
      expect(
        const DeepCollectionEquality().equals(
          RouteNavigator.relativeAbsolutePathMap,
          {},
        ),
        true,
        reason: 'map of relative and absolute paths should be initially empty',
      );
      final pathMap = {
        '/home': '/home',
        '/home/network': '/home/network',
      };
      RouteNavigator.setRelativeAbsolutePathMap(pathMap);
      expect(
        const DeepCollectionEquality().equals(
          RouteNavigator.relativeAbsolutePathMap,
          pathMap,
        ),
        true,
        reason: 'map of relative and absolute paths is incorrect',
      );
    });
  });
}

Future<void> createRouter(
  final List<RouteBase> routes,
  final WidgetTester tester, {
  final String initialRoutePath = '/home',
}) async {
  final pageRouter = PageRouter(
    routes: routes,
    onUnkownRouteException: (final _, final state, final router) {
      if (state.matchedLocation == '/') {
        router.go(initialRoutePath);
      }
    },
  );
  await tester.pumpWidget(MaterialApp.router(routerConfig: pageRouter));
}
