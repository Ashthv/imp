import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:tcs_dff_types/config.dart';

class RouteContent extends GoRoute implements RouteContentConfig {
  RouteContent({
    required this.routePath,
    required this.content,
    this.routes = const [],
    this.parentNavigatorKey,
    this.contentBuilder,
    this.transition,
  }) : super(
          path: routePath,
          builder: content,
          routes: routes,
          parentNavigatorKey: parentNavigatorKey,
          pageBuilder: contentBuilder,
        );

  @override
  final String routePath;

  @override
  set routePath(String _routePath) => _routePath = routePath;

  @override
  final ContentBuilder content;

  @override
  set content(ContentBuilder _content) => _content = content;

  @override
  final List<BaseRouteConfig> routes;

  @override
  set routes(List<BaseRouteConfig> _routes) => _routes = routes;

  @override
  final GlobalKey<NavigatorState>? parentNavigatorKey;

  final ContentPageBuilder? contentBuilder;

  final TransitionPageBuilder? transition;
}

class RoutePage extends ShellRoute implements RoutePageConfig {
  RoutePage({
    required this.page,
    required this.routes,
    this.parentNavigatorKey,
  }) : super(
          pageBuilder: page,
          routes: routes,
          parentNavigatorKey: parentNavigatorKey,
        );

  @override
  final PageBuilder page;

  @override
  set page(PageBuilder _page) => _page = page;

  @override
  final List<BaseRouteConfig> routes;

  @override
  set routes(List<BaseRouteConfig> _routes) => _routes = routes;

  @override
  final GlobalKey<NavigatorState>? parentNavigatorKey;
}

typedef ContentBuilder = GoRouterWidgetBuilder;
typedef PageBuilder = ShellRoutePageBuilder;
typedef BaseRouteConfig = RouteBase;
typedef RedirectHandler = GoRouterRedirect;
typedef ExceptionHandler = GoExceptionHandler;
typedef ContentPageBuilder = GoRouterPageBuilder;
typedef RouteState = GoRouterState;
typedef TransitionPageBuilder = CustomTransitionPage Function(
  ValueKey<String> key,
  Widget child,
);
