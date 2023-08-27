import 'package:firebase_login_app/pages/auth/authentication/authentication_page.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static void showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));

    messengerKey.currentState
      ?..clearSnackBars()
      ..showSnackBar(snackBar);
  }

  static Future<bool?> showExitWarning(BuildContext context) async =>
      showDialog(
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

  static void showLogoutWarning(BuildContext context,
      {String? title, String? message}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title ?? 'Log out'),
          content: Text(message ?? 'You sure you want to log out?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                context.read<UserRepository>().logout();
                Navigator.of(context).popUntil((route) => route.isFirst);
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
