import 'package:firebase_login_app/pages/authentication/authentication_page.dart';
import 'package:firebase_login_app/pages/authentication/email_verification/email_verification_page.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserRepository.user;

    return user == null
        ? const AuthenticationPage()
        : const EmailVerificationPage();
  }
}
