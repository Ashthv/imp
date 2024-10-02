import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';
import 'package:tcs_dff_types/config.dart';
import 'package:tcs_dff_types/platform.dart';

const String _localeStorageKey = '__locale_key__';
const String _localeCollection = 'locale';

final languageLocaleMap = {
  'en': 'English',
  // 'mr': 'मराठी',
  'hi': 'हिंदी',
};

Future<void> storeLocale(final String locale) => dff.storage.setItem(
      collectionName: _localeCollection,
      key: _localeStorageKey,
      item: locale,
    );

String? getStoredLocale() => 'en';

Locale? getLocale() {
  final storedLang = getStoredLocale();
  return storedLang != null ? Locale(storedLang) : null;
}

List<Locale> getSupportedLocales() {
  final localeList = <Locale>[];
  for (final element in languageLocaleMap.keys.toList()) {
    localeList.add(Locale(element));
  }
  return localeList;
}

List<LocalizationsDelegate<Object>> getLocalizationsDelegates() => [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];

LocaleConfig getLocaleConfig({final ApiConfig? apiConfig}) => LocaleConfig(
      locale: getLocale(),
      supportedLocale: getSupportedLocales(),
      localizationsDelegateList: getLocalizationsDelegates(),
    );
