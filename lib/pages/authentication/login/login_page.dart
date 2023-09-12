import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:firebase_login_app/pages/authentication/login/components/welcome_back_avatar.dart';
import 'package:firebase_login_app/pages/authentication/login/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
    required this.switchToRegisterPage,
  });

  final VoidCallback switchToRegisterPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              const WelcomeBackAvatar(),
              const SizedBox(height: 30),
              const LoginForm(),
              const SizedBox(height: 10),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(context.localize(LocKeys.dontHaveAccount)),
                  TextButton(
                    onPressed: () => switchToRegisterPage(),
                    child: Text(context.localize(LocKeys.goRegister)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
