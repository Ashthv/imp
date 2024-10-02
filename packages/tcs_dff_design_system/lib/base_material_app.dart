import 'package:flutter/material.dart';
import 'package:tcs_dff_types/config.dart' as config;

MaterialApp baseMaterialApp({
  required final RouterConfig<Object> router,
  required final config.UIConfig uiConfig,
}) =>
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: uiConfig.themeConfig?.themeData,
      routerConfig: router,
      locale: uiConfig.localeConfig.locale,
      supportedLocales: uiConfig.localeConfig.supportedLocale,
      localizationsDelegates: uiConfig.localeConfig.localizationsDelegateList,
      
    );
