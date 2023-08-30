import 'package:firebase_login_app/components/my_text_form_field.dart';
import 'package:firebase_login_app/models/form_validator.dart';
import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/pages/authentication/email_verification/email_verification_page.dart';
import 'package:firebase_login_app/pages/authentication/forgot_password/forgot_password_page.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MyTextFormField(
            controller: _emailController,
            hintText: 'Email',
            prefixIcon: const Icon(Icons.email_outlined),
            validator: FormValidator.validateEmail,
          ),
          const SizedBox(height: 12),
          MyTextFormField(
            controller: _passwordController,
            obscureText: true,
            hideButton: true,
            validator: FormValidator.validatePassword,
            hintText: 'Password',
            prefixIcon: const Icon(Icons.lock_outline),
          ),
          TextButton(
            onPressed: pushForgotPasswordPage,
            child: const Text('Forgot Password?'),
          ),
          const SizedBox(height: 10),
          FilledButton(
            // onPressed: login,
            onPressed: login,
            child: const Text('LOGIN'),
          ),
        ],
      ),
    );
  }

  void pushForgotPasswordPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
    );
  }

  void login() async {
    final isValidationPassed = _formKey.currentState?.validate() ?? false;

    if (isValidationPassed) {
      final success = await Utils.showLoading(
        context,
        UserRepository.authenticate(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );

      if (success && mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const EmailVerificationPage(),
        ));
      }
    }
  }
}
