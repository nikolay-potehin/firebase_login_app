import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:firebase_login_app/theme.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserRepository.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text("You're logged in", style: TextStyle(fontSize: 20)),
              if (user?.displayName != null) ...[
                const SizedBox(height: 30),
                Text(
                  user!.displayName!,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 10),
              Text(
                user?.email ?? '-',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: myPrimarySwatch,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => Utils.showLogoutWarning(context),
                child: const Text('LOG OUT'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
