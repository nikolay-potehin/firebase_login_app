import 'package:firebase_login_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  const RouteGenerator._();

  static const homePage = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );

      default:
        throw const RouteException('Route not found');
    }
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
