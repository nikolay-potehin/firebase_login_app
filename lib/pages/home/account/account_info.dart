import 'package:firebase_login_app/extensions/timestamp_extensions.dart';
import 'package:firebase_login_app/models/user_data.dart';
import 'package:firebase_login_app/theme.dart';
import 'package:flutter/material.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({
    required this.user,
    super.key,
  });

  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          user.displayName,
          style: const TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          user.email,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: myPrimarySwatch,
          ),
          textAlign: TextAlign.center,
        ),
        const Divider(thickness: 1, height: 32),
        Text(
          'Created at: ${user.creationTime.toTimeString()}',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
