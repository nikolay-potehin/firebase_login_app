import 'package:firebase_login_app/pages/authentication/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatelessWidget {
  final VoidCallback onRegisterPressed;
  const LoginPage({
    super.key,
    required this.onRegisterPressed,
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
            const LoginForm(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                const SizedBox(width: 10),
                TextButton.icon(
                  onPressed: onRegisterPressed,
                  icon: const Icon(Icons.vpn_key),
                  label: const Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
