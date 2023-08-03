import 'package:firebase_login_app/blocs/authentication/authentication_bloc.dart';
import 'package:firebase_login_app/blocs/credentials/credentials_bloc.dart';
import 'package:firebase_login_app/pages/login/login_view.dart';
import 'package:firebase_login_app/repository/user_repository/firebase_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = context.read<FirebaseUserRepository>();
    final authBloc = context.read<AuthenticationBloc>();

    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => CredentialsBloc(
          userRepository: repository,
          authenticationBloc: authBloc,
        ),
        child: const LoginView(),
      ),
    );
  }
}
