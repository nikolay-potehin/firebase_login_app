import 'package:firebase_login_app/pages/authentication/authentication_page.dart';
import 'package:firebase_login_app/repository/user_repository.dart';
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
            onPressed: () => _onLogoutPressed(context),
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      drawer: const Drawer(),
      body: const WelcomeView(),
    );
  }
}

class WelcomeView extends StatelessWidget {
  const WelcomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserRepository>().user;

    return Center(
      child: Column(
        children: [
          const Spacer(),
          const Text("You're logged in"),
          const SizedBox(height: 10),
          Text('UID: ${user?.uid ?? '-'}'),
          const Spacer(),
        ],
      ),
    );
  }
}

void _onLogoutPressed(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Log out'),
        content: const Text('You sure you want to log out?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<UserRepository>().logOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (_) => const AuthenticationPage(),
              ));
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}
