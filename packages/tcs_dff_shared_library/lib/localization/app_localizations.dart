import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcs_dff_core/app_builder.dart';
import 'package:tcs_dff_types/config.dart';
import 'package:tcs_dff_types/platform.dart';

class AppLocalizations {
  late final Locale _locale;
  AppLocalizations(this._locale);

  static AppLocalizations? of(final BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  static String getCurrentLocale(final BuildContext context) =>
      Localizations.localeOf(context).toString();

  late Map<String, String> _localizedValues;

  Future loadLanguage() async {
    final arbStringValue = await rootBundle.loadString(
      'packages/shared/lib/resource/strings/app_${_locale.languageCode}.json',
    );
    final mappedValues = json.decode(arbStringValue) as Map<String, dynamic>;

    _localizedValues = mappedValues.map(
      (final key, final value) => MapEntry(
        key,
        value.toString(),
      ),
    );

    if (localeApiConfig != null) {
      await getLocaleFromNetwork(localeApiConfig!);
    }
  }

  Future getLocaleFromNetwork(final ApiConfig apiConfig) async {
    final response = await dff.network.auth.post(apiConfig: apiConfig);

    if (response.statusCode == 200) {
      final localeData = json.decode(response.body) as Map<String, dynamic>;

      _localizedValues = localeData.map(
        (final key, final value) => MapEntry(
          key,
          value.toString(),
        ),
      );
    }
  }

  String txt({required final String key, final Map<String, String>? args}) {
    // for pattern ${placeHolder}
    final placeHolderPattern = RegExp(r'\${([^}]+)}');
    var localeTxt = _localizedValues[key] ?? '';
    if (args != null) {
      localeTxt = localeTxt.replaceAllMapped(placeHolderPattern, (final match) {
        final argKey = match.group(1);
        if (argKey != null) {
          return args[argKey] ?? '';
        }
        return '';
      });
    }
    return localeTxt;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(final Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(final Locale locale) async {
    final appLocalizations = AppLocalizations(locale);
    await appLocalizations.loadLanguage();
    return appLocalizations;
  }

  @override
  bool shouldReload(final _AppLocalizationsDelegate old) => false;
}

extension LocaleExtension on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this)!;
}
