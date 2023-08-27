import 'package:firebase_login_app/pages/auth/login/components/welcome_back_avatar.dart';
import 'package:firebase_login_app/pages/auth/login/login_form.dart';
import 'package:firebase_login_app/repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

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
                  const Text("Don't have account?"),
                  TextButton(
                    onPressed: () => switchToRegisterPage(context),
                    child: const Text('Create a new account'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void switchToRegisterPage(BuildContext context) {
    context.read<AuthenticationRepository>().currentPage = AuthPages.register;
  }
}
