import 'package:firebase_login_app/pages/auth/authentication/authentication_page.dart';
import 'package:firebase_login_app/pages/welcome/welcome_page.dart';
import 'package:firebase_login_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserRepository>().user;

    if (user != null && user.emailVerified) {
      return const WelcomePage();
    }
    return const AuthenticationPage();
  }
}
