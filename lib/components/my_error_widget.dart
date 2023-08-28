import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Icon(
            Icons.error_outline,
            size: 30,
            color: Colors.red,
          ),
          const SizedBox(height: 10),
          Text(message ?? 'Error'),
        ],
      ),
    );
  }
}
