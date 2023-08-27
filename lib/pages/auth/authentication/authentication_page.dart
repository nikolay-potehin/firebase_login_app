import 'package:firebase_login_app/pages/auth/authentication/authentication_view.dart';
import 'package:firebase_login_app/repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthenticationRepository(),
        child: const AuthenticationView());
  }
}
