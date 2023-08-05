import 'package:firebase_login_app/pages/authentication/register/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterPage extends StatelessWidget {
  final VoidCallback onLoginPressed;
  const RegisterPage({
    super.key,
    required this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/flutter_logo.svg',
            ),
            const SizedBox(height: 20),
            const RegisterForm(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already a user?"),
                const SizedBox(width: 10),
                TextButton.icon(
                  onPressed: onLoginPressed,
                  icon: const Icon(Icons.login),
                  label: const Text('Sign In'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
