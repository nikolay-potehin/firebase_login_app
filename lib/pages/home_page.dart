import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/pages/login/login_page.dart';
import 'package:firebase_login_app/pages/welcome_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return const WelcomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
