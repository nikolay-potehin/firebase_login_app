import 'dart:async';

import 'package:firebase_login_app/pages/authentication/email_verification/email_verification_view.dart';
import 'package:firebase_login_app/pages/home/home_page.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  bool isEmailVerified = false;
  Timer? timer;
  late final UserRepository userRepository;

  @override
  void initState() {
    super.initState();
    userRepository = context.read<UserRepository>();

    isEmailVerified = userRepository.user?.emailVerified ?? false;

    if (!isEmailVerified) {
      userRepository.sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) {
          if (mounted) checkEmailVerified();
        },
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void checkEmailVerified() async {
    await userRepository.reloadUser();

    setState(() {
      isEmailVerified = userRepository.user?.emailVerified ?? false;
    });

    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified ? const HomePage() : const EmailVerificationView();
  }
}
