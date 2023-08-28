import 'dart:async';

import 'package:firebase_login_app/pages/authentication/email_verification/email_verification_view.dart';
import 'package:firebase_login_app/pages/home/home_page.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = UserRepository.user?.emailVerified ?? false;

    if (!isEmailVerified) {
      UserRepository.sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void checkEmailVerified() async {
    await UserRepository.reload();
    if (mounted) {
      setState(() {
        isEmailVerified = UserRepository.user?.emailVerified ?? false;
      });
    }

    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    UserRepository.reload();

    return isEmailVerified ? const HomePage() : const EmailVerificationView();
  }
}
