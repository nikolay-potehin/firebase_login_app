import 'package:flutter/material.dart';

enum AuthPages { login, register }

class AuthenticationRepository with ChangeNotifier {
  AuthPages _currentPage = AuthPages.login;
  AuthPages get currentPage => _currentPage;
  set currentPage(AuthPages page) {
    _currentPage = page;
    notifyListeners();
  }
}
