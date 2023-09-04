import 'package:flutter/material.dart';

class NewAccountTitle extends StatelessWidget {
  const NewAccountTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Create Account',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Create New Account',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
