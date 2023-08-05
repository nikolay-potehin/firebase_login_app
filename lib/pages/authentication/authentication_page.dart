import 'package:firebase_login_app/pages/authentication/login/login_page.dart';
import 'package:firebase_login_app/pages/authentication/register/register_page.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  var isLoginPage = true;

  @override
  Widget build(BuildContext context) {
    return isLoginPage
        ? LoginPage(
            onRegisterPressed: _switchPage,
          )
        : RegisterPage(
            onLoginPressed: _switchPage,
          );
  }

  void _switchPage() {
    isLoginPage = !isLoginPage;
    setState(() {});
  }
}
