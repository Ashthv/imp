import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tcs_dff_route/tcs_dff_route.dart';
import 'package:tcs_dff_storage/cache/cache_policy.dart';

typedef AppBarBuilder = PreferredSizeWidget? Function(String routePath);
typedef BottomBarBuilder = Widget? Function(String routePath);
typedef BackButtonHandler = bool Function(
  String routePath,
  BuildContext context,
);

class FeatureConfig {
  final String name;
  final List<RouteContent> routes;
  final ContentBuilder content;
  final PageBuilder? page;
  final AppBarBuilder? appBar;
  final BottomBarBuilder? bottomBar;
  final TransitionPageBuilder? transition;
  final BackButtonHandler? backButtonHandler;

  FeatureConfig({
    required this.name,
    this.routes = const [],
    required this.content,
    this.page,
    this.appBar,
    this.bottomBar,
    this.transition,
    this.backButtonHandler,
  });
}

class AppBarConfig {
  final String title;
  final String? subTitle;

  AppBarConfig({required this.title, required this.subTitle});
}

abstract interface class RouterConfig {
  late final List<BaseRouteConfig> routes;
  late final ExceptionHandler onUnkownRouteException;
}

abstract interface class RouteContentConfig {
  late final String routePath;
  late final ContentBuilder content;
  late final List<BaseRouteConfig> routes;
}

abstract interface class RoutePageConfig {
  late final PageBuilder page;
  late final List<BaseRouteConfig> routes;
}

class ApiConfig {
  Uri url;
  Map<String, String>? headers;
  Object? body;
  final Encoding? encoding;
  Duration? timeOut;
  int retry;
  CachePolicy cachePolicy;
  StubConfig? stubConfig;

  ApiConfig({
    required this.url,
    this.body,
    this.headers,
    this.encoding,
    this.timeOut,
    this.retry = 0,
    this.cachePolicy = const CachePolicy(storageKey: ''),
    this.stubConfig,
  });
}

class StubConfig {
  bool stubEnabled;
  String jsonFilePath;
  StubConfig({
    this.stubEnabled = true,
    required this.jsonFilePath,
  });
}

class VideoPlayerConfig {
  String title;
  Uri videoLink;

  VideoPlayerConfig({
    required this.title,
    required this.videoLink,
  });
}

class LocaleConfig {
  Locale? locale;
  List<Locale> supportedLocale;
  List<LocalizationsDelegate<Object>> localizationsDelegateList;
  ApiConfig? localeApiConfig;

  LocaleConfig({
    this.locale,
    required this.supportedLocale,
    required this.localizationsDelegateList,
    this.localeApiConfig,
  });
}

class ThemeConfig {
  ThemeData themeData;

  ThemeConfig({
    required this.themeData,
  });
}

class UIConfig {
  LocaleConfig localeConfig;
  ThemeConfig? themeConfig;

  UIConfig({
    required this.localeConfig,
    this.themeConfig,
  });
}

// ignore: one_member_abstracts
abstract interface class Interceptor {
  void callback(final Exception exception, final StackTrace stackTrace);
}
