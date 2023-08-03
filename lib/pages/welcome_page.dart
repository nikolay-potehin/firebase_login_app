import 'package:firebase_login_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login App'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(const LoggedOut());
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      drawer: const Drawer(),
      body: const Center(
        child: Text("You're logged in"),
      ),
    );
  }
}
