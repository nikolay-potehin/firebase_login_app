import 'package:firebase_login_app/blocs/authentication/authentication_bloc.dart';
import 'package:firebase_login_app/pages/login/login_page.dart';
import 'package:firebase_login_app/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 2,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void loginTransition() {
    if (tabController.index != 1) tabController.animateTo(1);
  }

  void logoutTransition() {
    if (tabController.index != 0) tabController.animateTo(0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          loginTransition();
        }

        if (state is AuthenticationRevoked) {
          logoutTransition();
        }

        return TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: const [
            LoginPage(),
            WelcomePage(),
          ],
        );
      },
    );
  }
}
