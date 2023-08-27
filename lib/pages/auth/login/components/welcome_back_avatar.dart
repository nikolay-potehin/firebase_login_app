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
        const Text(
          'Welcome back',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Sign In to continue',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
