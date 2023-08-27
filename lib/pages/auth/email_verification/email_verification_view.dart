import 'dart:async';

import 'package:firebase_login_app/pages/auth/authentication/authentication_page.dart';
import 'package:firebase_login_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              '"${context.read<UserRepository>().user?.email}"',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: logout,
              child: const Text('CANCEL'),
            ),
          ],
        ),
      ),
    );
  }

  Future logout() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cancel'),
          content: const Text(
              'You sure you want to cancel email verification & log out?'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                context.read<UserRepository>().logOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => const AuthenticationPage(),
                ));
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
