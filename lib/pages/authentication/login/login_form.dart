import 'package:firebase_login_app/components/my_text_form_field.dart';
import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:firebase_login_app/models/form_validator.dart';
import 'package:firebase_login_app/pages/authentication/email_verification/email_verification_page.dart';
import 'package:firebase_login_app/pages/authentication/forgot_password/forgot_password_page.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:firebase_login_app/utils.dart';
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
            hintText: context.localize(LocKeys.email),
            prefixIcon: const Icon(Icons.email_outlined),
            validator: (value) => FormValidator.validateEmail(context, value),
          ),
          const SizedBox(height: 12),
          MyTextFormField(
            controller: _passwordController,
            obscureText: true,
            hideButton: true,
            validator: (value) =>
                FormValidator.validatePassword(context, value),
            hintText: context.localize(LocKeys.password),
            prefixIcon: const Icon(Icons.lock_outline),
          ),
          TextButton(
            onPressed: pushForgotPasswordPage,
            child: Text(context.localize(LocKeys.forgotPassword)),
          ),
          const SizedBox(height: 10),
          FilledButton(
            // onPressed: login,
            onPressed: login,
            child: Text(context.localize(LocKeys.loginBtn).toUpperCase()),
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
