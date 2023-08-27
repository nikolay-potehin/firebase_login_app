import 'package:firebase_login_app/components/my_drawer.dart';
import 'package:firebase_login_app/pages/auth/authentication/authentication_page.dart';
import 'package:firebase_login_app/pages/welcome/welcome_view.dart';
import 'package:firebase_login_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login App'),
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: const WelcomeView(),
    );
  }
}

void logout(BuildContext context) {
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
