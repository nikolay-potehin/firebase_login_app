import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ["en", "ru"].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) =>
      SynchronousFuture<AppLocalization>(AppLocalization(locale));

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) =>
      false;
}
