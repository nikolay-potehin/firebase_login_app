import 'package:firebase_login_app/components/my_text_form_field.dart';
import 'package:firebase_login_app/models/form_validator.dart';
import 'package:firebase_login_app/pages/auth/email_verification/email_verification_page.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          MyTextFormField(
            controller: _usernameController,
            validator: FormValidator.validateDefault,
            hintText: 'Name',
            prefixIcon: const Icon(Icons.person_outline),
          ),
          const SizedBox(height: 16),
          MyTextFormField(
            controller: _emailController,
            validator: FormValidator.validateEmail,
            hintText: 'Email',
            prefixIcon: const Icon(Icons.email_outlined),
          ),
          const SizedBox(height: 16),
          MyTextFormField(
            controller: _passwordController,
            obscureText: true,
            validator: (password) => FormValidator.validatePassword(
              password,
              compareTo: _passwordConfirmController.text,
            ),
            prefixIcon: const Icon(Icons.lock_outline),
            hintText: 'Password',
          ),
          const SizedBox(height: 16),
          MyTextFormField(
            controller: _passwordConfirmController,
            obscureText: true,
            validator: (password) => FormValidator.validatePassword(
              password,
              compareTo: _passwordController.text,
            ),
            hintText: 'Confrim Password',
            prefixIcon: const Icon(Icons.lock_outline),
          ),
          const SizedBox(height: 30),
          FilledButton(
            onPressed: _registerButtonPressed,
            child: const Text('CREATE ACCOUNT'),
          ),
        ],
      ),
    );
  }

  void _registerButtonPressed() async {
    final isValidationPassed = _formKey.currentState?.validate() ?? false;

    if (isValidationPassed) {
      showDialog(
          barrierDismissible: false,
          context: Scaffold.of(context).context,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));

      final success = await context.read<UserRepository>().register(
            _emailController.text,
            _passwordController.text,
          );

      Navigator.of(context).popUntil((route) => route.isFirst);

      if (success) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const EmailVerificationPage(),
        ));
      }
    }
  }
}
