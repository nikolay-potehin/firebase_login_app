import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  final double radius = 60;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: radius,
          child: Icon(Icons.person, size: radius * 1.2),
        ),
        FloatingActionButton.small(
          onPressed: () {},
          foregroundColor: Colors.white,
          child: const Icon(Icons.edit),
        ),
      ],
    );
  }
}
