import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _usernameController = usernameController,
        _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _usernameController;
  final TextEditingController _passwordController;

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
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            maxLength: 20,
            validator: _validate,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp('[/\\ ]'))
            ],
          ),
        ],
      ),
    );
  }
}

String? _validate(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field cannot be empty';
  }
  return null;
}
