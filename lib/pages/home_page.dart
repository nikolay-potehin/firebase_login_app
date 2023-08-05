import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/pages/authentication/authentication_page.dart';
import 'package:firebase_login_app/pages/welcome_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return const WelcomePage();
    }
    return const AuthenticationPage();
  }
}
