import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/pages/home/account/account_page.dart';
import 'package:firebase_login_app/pages/home/inbox/inbox_page.dart';
import 'package:firebase_login_app/pages/home/people/people_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await Utils.showExitWarning(context);

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
  PeoplePage(),
  AccountPage(),
];
