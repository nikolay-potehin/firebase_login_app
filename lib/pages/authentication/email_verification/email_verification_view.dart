import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/pages/authentication/authentication_page.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({
    super.key,
  });

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Email Verification')),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'A verification email has been sent to your email '
              '"${UserRepository.user?.email}"',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () async {
                final shouldLogout = await Utils.showWarning(
                      context,
                      title: 'Cancel & log out',
                      content:
                          'You sure you want to cancel email verification & log out?',
                      barrierDismissible: false,
                    ) ??
                    false;

                if (shouldLogout) logout();
              },
              child: const Text('CANCEL'),
            ),
          ],
        ),
      ),
    );
  }

  void logout() {
    UserRepository.logout();
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => const AuthenticationPage(),
    ));
  }
}
