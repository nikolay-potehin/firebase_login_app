import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:flutter/material.dart';

class NewAccountTitle extends StatelessWidget {
  const NewAccountTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.localize(LocKeys.createAccountTitle),
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          context.localize(LocKeys.createAccountSubtitle),
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
