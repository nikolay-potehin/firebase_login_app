import 'package:firebase_login_app/pages/auth/register/components/new_account_title.dart';
import 'package:firebase_login_app/pages/auth/register/register_form.dart';
import 'package:firebase_login_app/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({
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
              const NewAccountTitle(),
              const SizedBox(height: 30),
              const RegisterForm(),
              const SizedBox(height: 10),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text("Already a user?"),
                  TextButton(
                    onPressed: () => switchToLoginPage(context),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void switchToLoginPage(BuildContext context) {
    context.read<AuthenticationRepository>().currentPage = AuthPages.login;
  }
}
