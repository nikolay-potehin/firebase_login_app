import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:firebase_login_app/pages/authentication/forgot_password/forgot_password_form.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.localize(LocKeys.resetPasswordTitle))),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.localize(LocKeys.receiveEmailToResetPassword),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            const ForgotPasswordForm(),
          ],
        ),
      ),
    );
  }
}
