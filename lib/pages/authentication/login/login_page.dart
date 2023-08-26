import 'package:firebase_login_app/pages/authentication/forgot_password_page.dart';
import 'package:firebase_login_app/pages/authentication/login/login_form.dart';
import 'package:firebase_login_app/repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/flutter_logo.svg'),
                      const SizedBox(height: 10),
                      const LoginForm(),
                      const SizedBox(height: 10),
                      TextButton.icon(
                        icon: const Icon(Icons.lock_reset_outlined),
                        label: const Text('Forgot password?'),
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const ForgotPasswordPage())),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(width: 10),
                  TextButton.icon(
                    onPressed: () => context
                        .read<AuthenticationRepository>()
                        .currentPage = AuthPages.register,
                    icon: const Icon(Icons.vpn_key),
                    label: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
