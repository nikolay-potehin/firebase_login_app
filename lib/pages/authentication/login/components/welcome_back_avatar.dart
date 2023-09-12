import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:flutter/material.dart';

class WelcomeBackAvatar extends StatelessWidget {
  const WelcomeBackAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.account_circle,
          size: 120,
          color: Colors.grey.shade200,
        ),
        Text(
          context.localize(LocKeys.welcomeBack),
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          context.localize(LocKeys.signInToContinue),
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
