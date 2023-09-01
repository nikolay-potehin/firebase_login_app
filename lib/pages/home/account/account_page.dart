import 'package:firebase_login_app/models/inbox_model.dart';
import 'package:firebase_login_app/models/user_data.dart';
import 'package:firebase_login_app/models/users_model.dart';
import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/pages/authentication/authentication_page.dart';
import 'package:firebase_login_app/pages/home/account/user_avatar.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:firebase_login_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: const Center(
        child: _AccountPageBody(),
      ),
    );
  }
}

class _AccountPageBody extends StatelessWidget {
  const _AccountPageBody();

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersModel>(
      builder: (context, model, _) {
        if (model.currentUser == null) {
          return const CircularProgressIndicator();
        } else {
          final user = UserData.fromDocument(model.currentUser!);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const UserAvatar(),
                const SizedBox(height: 30),
                Text(
                  user.displayName,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: myPrimarySwatch,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Expanded(child: SizedBox()),
                FilledButton(
                  onPressed: () async {
                    final shouldLogout = await Utils.showWarning(
                          context,
                          title: 'Log out',
                          content: 'You sure you want to log out?',
                          barrierDismissible: false,
                        ) ??
                        false;

                    if (shouldLogout && context.mounted) _logout(context);
                  },
                  child: const Text('LOG OUT'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

void _logout(BuildContext context) {
  context.read<UsersModel>().cancel();
  context.read<InboxModel>().cancel();

  UserRepository.logout();

  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (_) => const AuthenticationPage(),
  ));
}
