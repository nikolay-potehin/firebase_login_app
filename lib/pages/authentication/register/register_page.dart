import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:firebase_login_app/pages/authentication/register/components/new_account_title.dart';
import 'package:firebase_login_app/pages/authentication/register/register_form.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({
    super.key,
    required this.switchToLoginPage,
  });

  final VoidCallback switchToLoginPage;

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
                  Text(context.localize(LocKeys.alreadyAUser)),
                  TextButton(
                    onPressed: () => switchToLoginPage(),
                    child: Text(context.localize(LocKeys.goLogin)),
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
