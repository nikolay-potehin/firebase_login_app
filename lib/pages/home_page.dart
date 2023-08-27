import 'package:firebase_login_app/pages/auth/authentication/authentication_page.dart';
import 'package:firebase_login_app/pages/auth/email_verification/email_verification_page.dart';
import 'package:firebase_login_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<bool?> showWarning(BuildContext context) async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Do you want to exit app?'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Yes'),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserRepository>().user;

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);

        return shouldPop ?? false;
      },
      child: user == null
          ? const AuthenticationPage()
          : const EmailVerificationPage(),
    );
  }
}
