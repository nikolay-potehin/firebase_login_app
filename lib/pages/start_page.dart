import 'package:firebase_login_app/pages/auth/authentication/authentication_page.dart';
import 'package:firebase_login_app/pages/auth/email_verification/email_verification_page.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserRepository>().user;

    return user == null
        ? const AuthenticationPage()
        : const EmailVerificationPage();
  }
}
