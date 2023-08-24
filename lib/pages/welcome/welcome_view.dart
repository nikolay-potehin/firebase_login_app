import 'package:firebase_login_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserRepository>().user;

    return Center(
      child: Column(
        children: [
          const Spacer(),
          const Text("You're logged in"),
          const SizedBox(height: 10),
          Text('UID: ${user?.uid ?? '-'}'),
          const Spacer(),
        ],
      ),
    );
  }
}
