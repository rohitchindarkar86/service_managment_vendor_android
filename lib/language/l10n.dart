import 'package:flutter/material.dart';

class L10n {
  static final List<Locale> locales = [
    const Locale.fromSubtags(languageCode: 'en', countryCode: 'IN'),
    const Locale.fromSubtags(languageCode: 'hi', countryCode: 'IN'),
    const Locale.fromSubtags(languageCode: 'mr', countryCode: 'IN'),
  ];
}

class LanguageOptions {
  final Map<String, Locale> localeOptions = {};
  final Map<String, String> langNameFromCode = {};
  static const List<String> languages = const [
    "English",
    "हिंदी",
    "मराठी",
  ];

  LanguageOptions() {
    _setValues();
  }

  void _setValues() {
    for (int i = 0; i < L10n.locales.length; i++) {
      localeOptions.putIfAbsent(
          languages.elementAt(i), () => L10n.locales.elementAt(i));
      langNameFromCode.putIfAbsent(
          L10n.locales.elementAt(i).languageCode, () => languages.elementAt(i));
    }
  }
}
