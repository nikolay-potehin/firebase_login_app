import 'package:firebase_login_app/models/inbox_model.dart';
import 'package:firebase_login_app/models/users_model.dart';
import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/pages/home/account/account_page.dart';
import 'package:firebase_login_app/pages/home/inbox/inbox_page.dart';
import 'package:firebase_login_app/pages/home/users/users_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InboxModel()),
        ChangeNotifierProvider(create: (_) => UsersModel()),
      ],
      child: const _HomePageView(),
    );
  }
}

class _HomePageView extends StatefulWidget {
  const _HomePageView();

  @override
  State<_HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<_HomePageView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await Utils.showWarning(
          context,
          title: 'Do you want to exit app?',
        );

        return shouldPop ?? false;
      },
      child: Scaffold(
        body: _pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: _bottomNavbarItems,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          onTap: (value) => setState(() => currentIndex = value),
        ),
      ),
    );
  }
}

const _bottomNavbarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.email_outlined),
    activeIcon: Icon(Icons.email),
    label: '',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.people_alt_outlined),
    activeIcon: Icon(Icons.people_alt),
    label: '',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_outline),
    activeIcon: Icon(Icons.person),
    label: '',
  ),
];

const _pages = [
  InboxPage(),
  UsersPage(),
  AccountPage(),
];
