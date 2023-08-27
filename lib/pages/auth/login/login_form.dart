import 'package:firebase_login_app/components/my_text_form_field.dart';
import 'package:firebase_login_app/models/form_validator.dart';
import 'package:firebase_login_app/pages/auth/email_verification/email_verification_page.dart';
import 'package:firebase_login_app/pages/auth/forgot_password/forgot_password_page.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          const SizedBox(height: 16),
          MyTextFormField(
            controller: _passwordController,
            obscureText: true,
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
      showDialog(
          barrierDismissible: false,
          context: Scaffold.of(context).context,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));

      final success = await context.read<UserRepository>().authenticate(
            _emailController.text,
            _passwordController.text,
          );

      Navigator.popUntil(context, (route) => route.isFirst);

      if (success) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const EmailVerificationPage(),
        ));
      }
    }
  }
}
