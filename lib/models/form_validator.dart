import 'package:firebase_login_app/extensions/string_extensions.dart';
import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:flutter/material.dart';

class FormValidator {
  static String? validateEmail(BuildContext context, String? email) {
    if (email == null || email.isEmpty) {
      return context.localize(LocKeys.onEmptyEmailError);
    }
    if (!email.isValidEmail()) {
      return context.localize(LocKeys.onInvalidEmailError);
    }
    return null;
  }

  static String? validatePassword(BuildContext context, String? password,
      {String? compareTo}) {
    if (password == null || password.isEmpty) {
      return context.localize(LocKeys.onEmptyPasswordError);
    }
    if (password.length < 6) {
      return context.localize(LocKeys.onPasswordTooShortError);
    }
    if (compareTo != null && password != compareTo) {
      return context.localize(LocKeys.onPasswordsDontMatchError);
    }
    return null;
  }

  static String? validateDefault(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.localize(LocKeys.onEmptyFieldError);
    }
    return null;
  }
}
