import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:firebase_login_app/models/inbox_appbar_manager.dart';
import 'package:firebase_login_app/models/inbox_model.dart';
import 'package:firebase_login_app/models/users_model.dart';
import 'package:firebase_login_app/pages/home/account/account_page.dart';
import 'package:firebase_login_app/pages/home/inbox/inbox_page.dart';
import 'package:firebase_login_app/pages/home/users/users_page.dart';
import 'package:firebase_login_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InboxModel(), lazy: false),
        ChangeNotifierProvider(create: (_) => UsersModel(), lazy: false),
        ChangeNotifierProvider(
            create: (_) => InboxAppbarManager(), lazy: false),
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
          title: context.localize(LocKeys.onAppExitWarning),
        );

        return shouldPop ?? false;
      },
      child: Scaffold(
        body: _pages[currentIndex],
        bottomNavigationBar: Consumer<InboxModel>(
          builder: (context, inbox, _) {
            final count = inbox.messagesCounter[Messages.unread];

            return BottomNavigationBar(
              currentIndex: currentIndex,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              onTap: (value) => setState(() => currentIndex = value),
              items: [
                BottomNavigationBarItem(
                  icon: Badge.count(
                    isLabelVisible: count != null && count > 0,
                    count: count ?? 0,
                    child: Icon(
                        currentIndex == 0 ? Icons.email : Icons.email_outlined),
                  ),
                  label: '',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.people_alt_outlined),
                  activeIcon: Icon(Icons.people_alt),
                  label: '',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: '',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

const _pages = [
  InboxPage(),
  UsersPage(),
  AccountPage(),
];
