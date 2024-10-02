import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' hide RouterConfig;
import 'package:go_router/go_router.dart';
import 'package:tcs_dff_types/config.dart';

import 'tcs_dff_route.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class PageRouter extends GoRouter implements RouterConfig {
  PageRouter({
    required this.routes,
    required this.onUnkownRouteException,
  }) : super.routingConfig(
          routingConfig: _ConstantRoutingConfig(
            RoutingConfig(
              routes: routes,
            ),
          ),
          navigatorKey: rootNavigatorKey,
          onException: onUnkownRouteException,
        );

  @override
  final List<BaseRouteConfig> routes;

  @override
  set routes(List<BaseRouteConfig> _routes) => _routes = routes;

  @override
  final ExceptionHandler onUnkownRouteException;

  @override
  set onUnkownRouteException(ExceptionHandler _onUnkownRouteException) =>
      _onUnkownRouteException = onUnkownRouteException;
}

/// A routing config that is never going to change.
class _ConstantRoutingConfig extends ValueListenable<RoutingConfig> {
  const _ConstantRoutingConfig(this.value);
  @override
  void addListener(final VoidCallback listener) {
    // Intentionally empty because listener will never be called.
  }
 
  @override
  void removeListener(final VoidCallback listener) {
    // Intentionally empty because listener will never be called.
  }
 
  @override
  final RoutingConfig value;
}

