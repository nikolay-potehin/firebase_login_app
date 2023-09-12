import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:firebase_login_app/pages/authentication/login/login_page.dart';
import 'package:firebase_login_app/pages/authentication/register/register_page.dart';
import 'package:firebase_login_app/utils.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool isLoginPageShown = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await Utils.showWarning(
          context,
          title: context.localize(LocKeys.onAppExitWarning),
        );

        return shouldPop ?? false;
      },
      child: Scaffold(
        body: isLoginPageShown
            ? LoginPage(
                switchToRegisterPage: () => setState(() {
                  isLoginPageShown = false;
                }),
              )
            : RegisterPage(
                switchToLoginPage: () => setState(() {
                  isLoginPageShown = true;
                }),
              ),
      ),
    );
  }
}
