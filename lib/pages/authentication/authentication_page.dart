import 'package:firebase_login_app/pages/authentication/login/login_page.dart';
import 'package:firebase_login_app/pages/authentication/register/register_page.dart';
import 'package:firebase_login_app/repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
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
