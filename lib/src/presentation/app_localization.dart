import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app_clean_code/src/common/constants/languages.dart';

class AppLocalization {
  final Locale locale;

  AppLocalization({required this.locale});

  static AppLocalization of(BuildContext context) {
    return Localizations.of(context, AppLocalization);
  }

  Map<String, dynamic> _localizedStrings = {};

  String translate(String key) {
    return _localizedStrings[key];
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationDelegate();

  Future<bool> load() async {
    final jsonString = await rootBundle
        .loadString('assets/languages/${locale.languageCode}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));

    return true;
  }
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return Lanuages.languages
        .map((e) => e.code)
        .toList()
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = AppLocalization(locale: locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) =>
      false;
}
