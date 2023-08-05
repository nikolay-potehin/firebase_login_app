import 'package:firebase_login_app/pages/welcome_page.dart';
import 'package:firebase_login_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
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
          TextFormField(
            controller: _usernameController,
            maxLength: 50,
            validator: _validate,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp('[/\\ ]'))
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            maxLength: 20,
            validator: (value) {
              return _validate(value) ?? _checkPasswords();
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp('[/\\ ]'))
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _passwordConfirmController,
            obscureText: true,
            maxLength: 20,
            validator: (value) {
              return _validate(value) ?? _checkPasswords();
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Confrim Password',
              prefixIcon: Icon(Icons.lock),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp('[/\\ ]'))
            ],
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            style: const ButtonStyle(
              minimumSize: MaterialStatePropertyAll(Size.fromHeight(50)),
            ),
            onPressed: _registerButtonPressed,
            icon: const Icon(Icons.vpn_key),
            label: const Text(
              'Sign Up',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  String? _checkPasswords() {
    if (_passwordController.text == _passwordConfirmController.text) {
      return null;
    }
    return 'Passwords are not equal';
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
            _usernameController.text,
            _passwordController.text,
          );

      Navigator.of(context).popUntil((route) => route.isFirst);

      if (success) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const WelcomePage(),
        ));
      }
    }
  }
}
