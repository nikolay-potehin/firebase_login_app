import 'package:firebase_login_app/blocs/authentication/authentication_bloc.dart';
import 'package:firebase_login_app/blocs/credentials/credentials_bloc.dart';
import 'package:firebase_login_app/pages/login/login_view.dart';
import 'package:firebase_login_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = context.read<UserRepository>();
    final authBloc = context.read<AuthenticationBloc>();

    return BlocProvider(
      create: (context) => CredentialsBloc(
        userRepository: repository,
        authenticationBloc: authBloc,
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Login App'),
        ),
        body: const LoginView(),
      ),
    );
  }
}
