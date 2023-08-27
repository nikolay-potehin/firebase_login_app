import 'package:firebase_login_app/pages/auth/login/login_page.dart';
import 'package:firebase_login_app/pages/auth/register/register_page.dart';
import 'package:firebase_login_app/repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = context.watch<AuthenticationRepository>();

    return Scaffold(
      body: authRepo.currentPage == AuthPages.login
          ? const LoginPage()
          : const RegisterPage(),
    );
  }
}
