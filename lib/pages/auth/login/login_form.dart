import 'package:firebase_login_app/models/form_validator.dart';
import 'package:firebase_login_app/pages/welcome/welcome_page.dart';
import 'package:firebase_login_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            maxLength: 50,
            validator: FormValidator.validateEmail,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp('[/\\ ]'))
            ],
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            maxLength: 20,
            validator: FormValidator.validatePassword,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp('[/\\ ]'))
            ],
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            style: const ButtonStyle(
              minimumSize: MaterialStatePropertyAll(Size.fromHeight(50)),
            ),
            onPressed: _loginButtonPressed,
            icon: const Icon(Icons.login),
            label: const Text(
              'Sign In',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  void _loginButtonPressed() async {
    final isValidationPassed = _formKey.currentState?.validate() ?? false;

    if (isValidationPassed) {
      showDialog(
          barrierDismissible: false,
          context: Scaffold.of(context).context,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));

      final success = await context.read<UserRepository>().authenticate(
            _usernameController.text,
            _passwordController.text,
          );

      Navigator.popUntil(context, (route) => route.isFirst);

      if (success) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const WelcomePage(),
        ));
      }
    }
  }
}
