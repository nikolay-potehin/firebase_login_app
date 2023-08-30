import 'package:flutter/material.dart';

class EmptyInboxWidget extends StatelessWidget {
  const EmptyInboxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Your Inbox is empty :(',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
