import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/pages/authentication/authentication_page.dart';
import 'package:firebase_login_app/pages/welcome/welcome_page.dart';
import 'package:firebase_login_app/repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return const WelcomePage();
    }
    return ChangeNotifierProvider(
      create: (context) => AuthenticationRepository(),
      child: const AuthenticationPage(),
    );
  }
}
