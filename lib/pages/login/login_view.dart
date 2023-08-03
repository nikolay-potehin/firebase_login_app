import 'package:firebase_login_app/blocs/credentials/credentials_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/flutter_logo.svg',
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Wrap(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    maxLength: 50,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    maxLength: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            BlocConsumer<CredentialsBloc, CredentialsState>(
              listener: (context, state) {
                if (state is CredentialsLoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Incorrect pair of username/password'),
                  ));
                }
              },
              builder: (context, state) {
                if (state is CredentialsLoginLoading) {
                  return const CircularProgressIndicator();
                }

                return ElevatedButton(
                  onPressed: _loginButtonPressed,
                  child: const Text('Login'),
                );
              },
            ),
            const SizedBox(height: 10),
            BlocConsumer<CredentialsBloc, CredentialsState>(
              listener: (context, state) {
                if (state is CredentialsRegisterFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please, try a different email'),
                  ));
                }
              },
              builder: (context, state) {
                if (state is CredentialsRegisterLoading) {
                  return const CircularProgressIndicator();
                }

                return FilledButton(
                  onPressed: _registerButtonPressed,
                  child: const Text('Register'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _loginButtonPressed() {
    final state = _formKey.currentState;

    if (state?.validate() ?? false) {
      context.read<CredentialsBloc>().add(LoginButtonPressed(
            username: _usernameController.text,
            password: _passwordController.text,
          ));
    }
  }

  void _registerButtonPressed() {
    final state = _formKey.currentState;

    if (state?.validate() ?? false) {
      context.read<CredentialsBloc>().add(RegisterButtonPressed(
            username: _usernameController.text,
            password: _passwordController.text,
          ));
    }
  }
}
