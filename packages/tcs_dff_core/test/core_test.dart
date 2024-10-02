import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tcs_dff_core/app_builder.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_route/tcs_dff_route.dart';
import 'package:tcs_dff_shared_library/logger/logger.dart';
import 'package:tcs_dff_test/dff_mocks.dart';
import 'package:tcs_dff_types/config.dart';
import 'package:tcs_dff_types/platform.dart';

final sharedFeatureList = [
  FeatureConfig(
    name: 'network',
    content: (final _, final __) =>
        const Text('Network Content', key: Key('network')),
    transition: (final key, final child) =>
        CustomSlideLeftTransition(key: key, child: child),
    backButtonHandler: (final routePath, final context) => true,
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

class MockBuildContext extends Mock implements BuildContext {}

// ignore: must_be_immutable
class MockRouteState extends Mock implements RouteState {
  MockRouteState({required this.matchedLocation});

  @override
  final String matchedLocation;

  @override
  ValueKey<String> get pageKey => const ValueKey('mockRouteState');
}

class MockUIConfig extends Mock implements UIConfig {
  @override
  LocaleConfig get localeConfig => LocaleConfig(
        supportedLocale: [],
        localizationsDelegateList: [],
        localeApiConfig: ApiConfig(url: Uri()),
      );
}

class MockConsoleLogger extends Mock implements ConsoleLogger {}

void main() {
  setUp(() {
    // Register fallback values for any required parameters
    registerFallbackValue(MockBuildContext());
  });

  group('Build Feature Map', () {
    test('feature map should be empty on passing empty feature list', () {
      final featureMap = buildMap([]);
      expect(featureMap.isEmpty, true);
    });

    test('feature map should not be empty on passing feature list', () {
      final featureMap = buildMap(sharedFeatureList);
      expect(featureMap.isNotEmpty, true);
    });

    test('every feature map values `page` should not be null', () {
      final featureMap = buildMap(sharedFeatureList);
      final contentPageNotNull = featureMap.values.every(
        (final element) => element.page != null,
      );
      expect(contentPageNotNull, true);
    });

    test(
      'verify `di` feature map entry (key & value) presence',
      () {
        final featureMap = buildMap(sharedFeatureList);

        final diFeatureMap = featureMap.entries
            .singleWhereOrNull((final element) => element.key == 'di');

        expect(
          diFeatureMap != null,
          true,
          reason: 'entry by key `di` not present',
        );

        expect(
          diFeatureMap!.value.name,
          'di',
          reason: 'value by name doesnt match',
        );

        expect(
          diFeatureMap.value.page != null,
          true,
          reason: 'value by page doesnt match',
        );

        expect(
          diFeatureMap.value.appBar,
          null,
          reason: 'value by appBar doesnt match',
        );

        expect(
          diFeatureMap.value.routes.length,
          1,
          reason: 'di routes length doesnt match',
        );

        expect(
          diFeatureMap.value.routes.firstOrNull?.routePath,
          'factory',
          reason: 'di routes first entry routePath value doesnt match',
        );

        expect(
          diFeatureMap.value.routes.firstOrNull?.content != null,
          true,
          reason: 'di routes first entry content value doesnt match',
        );

        expect(
          diFeatureMap.value.routes.firstOrNull?.routes,
          [],
          reason: 'di routes first entry routes value doesnt match',
        );
      },
    );
  });

  group('Wrapped Page', () {
    final mockBuildContext = MockBuildContext();
    final mockRouteState = MockRouteState(matchedLocation: '/');

    test('check feature `network` having animation', () {
      final wrapPage = wrappedPage(
        context: mockBuildContext,
        feature: sharedFeatureList.first,
        state: mockRouteState,
        child: sharedFeatureList.first.content.call(
          mockBuildContext,
          mockRouteState,
        ),
        featureList: sharedFeatureList,
      );

      expect(
        wrapPage is CustomSlideLeftTransition,
        true,
        reason: 'wrapPage type does not match',
      );

      expect(
        wrapPage.key,
        const ValueKey('mockRouteState'),
        reason: 'wrapPage key does not match',
      );
    });

    test('check feature `signUp` not having animation', () {
      final wrapPage = wrappedPage(
        context: mockBuildContext,
        feature: sharedFeatureList.last,
        state: mockRouteState,
        child: sharedFeatureList.last.content.call(
          mockBuildContext,
          mockRouteState,
        ),
        featureList: sharedFeatureList,
      );

      expect(
        wrapPage is CustomSlideLeftTransition,
        true,
        reason: 'wrapPage type does not match',
      );

      expect(
        wrapPage.key,
        const ValueKey('mockRouteState'),
        reason: 'wrapPage key does not match',
      );
    });
  });

  group('Assemble Feature', () {
    final mockBuildContext = MockBuildContext();
    final mockRouteState = MockRouteState(matchedLocation: '/');

    test('check feature `network`', () {
      final assembledFeaturePage = assembleFeature(
        mockBuildContext,
        sharedFeatureList.first,
        sharedFeatureList.first.content.call(
          mockBuildContext,
          mockRouteState,
        ),
        sharedFeatureList,
      );

      expect(
        assembledFeaturePage is BackButtonListener,
        true,
        reason: 'assembledFeaturePage type does not match',
      );

      expect(
        (assembledFeaturePage as BackButtonListener).child is Scaffold,
        true,
        reason: 'assembledFeaturePage child\'s type does not match',
      );
    });
  });

  group('Route Builder', () {
    setUp(() {
      dff = MockDffPlatform();
      when(
        () => dff.analytics.logEvent(
          eventName: any(named: 'eventName'),
          parameters: any(named: 'parameters'),
        ),
      ).thenAnswer((final _) => Future.value());
    });

    final featureConfigMap = buildMap(sharedFeatureList);
    final router = routeBuilder(featureConfigMap, '/home/di');

    test('check relative and absolute path map formation', () {
      final expectedRelativeAbsolutePathMap = {
        '/home': '/home',
        '/home/network': '/home/network',
        '/home/di': '/home/di',
        '/di/factory': '/home/di/factory',
        '/home/rewards': '/home/rewards',
        '/rewards/network': '/home/rewards/network',
        '/signUp': '/signUp',
      };

      expect(
        const DeepCollectionEquality().equals(
          RouteNavigator.relativeAbsolutePathMap,
          expectedRelativeAbsolutePathMap,
        ),
        true,
        reason: 'map of relative path and absolute path is incorrect',
      );
    });

    test('check routeBuilder return type', () {
      expect(
        router is PageRouter,
        true,
        reason: 'router type does not match',
      );
    });

    test('check onUnkownRouteException', () {
      final mockBuildContext = MockBuildContext();
      final consoleLogger = MockConsoleLogger();
      when(() => consoleLogger.log(any()));

      final mockRouteState = MockRouteState(matchedLocation: '/home');
      (router as PageRouter)
          .onUnkownRouteException
          .call(mockBuildContext, mockRouteState, router);
      expect(
        mockRouteState.matchedLocation,
        '/home',
        reason: 'matchedLocation value does not match',
      );

      final mockRouteStateRoot = MockRouteState(matchedLocation: '/');
      router.onUnkownRouteException
          .call(mockBuildContext, mockRouteStateRoot, router);
      expect(
        mockRouteStateRoot.matchedLocation,
        '/',
        reason: 'matchedLocation value does not match',
      );
    });
  });

  group('Launch App', () {
    setUp(() {
      launchApp(
        featureList: sharedFeatureList,
        initialRoutePath: '/home/di',
        uiConfig: MockUIConfig(),
      );
    });

    test('check localeApiConfig value', () {
      expect(
        localeApiConfig != null,
        true,
        reason: 'localeApiConfig value does not match',
      );
    });
  });

  group('findParent', () {
    test('should return the correct FeatureConfig when the match is found', () {
      const fullpath = '/home/network';
      final result = findParent(fullpath, sharedFeatureList);

      expect(result.name, 'network');
    });

    test('should return the correct FeatureConfig when the match is the root',
        () {
      const fullpath = '/home';
      final result = findParent(fullpath, sharedFeatureList);

      expect(result.name, 'home');
    });

    test('should throw an error when no match is found', () {
      const fullpath = '/unknown';

      expect(() => findParent(fullpath, sharedFeatureList), throwsStateError);
    });

    test('should handle paths with multiple segments correctly', () {
      const fullpath = '/home/di/factory';
      final result = findParent(fullpath, sharedFeatureList);

      expect(result.name, 'di');
    });

    test('should handle empty path segments correctly', () {
      const fullpath = '/home//network';
      final result = findParent(fullpath, sharedFeatureList);

      expect(result.name, 'network');
    });
  });
}
