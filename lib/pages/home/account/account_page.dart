import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/components/user_avatar.dart';
import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:firebase_login_app/models/inbox_model.dart';
import 'package:firebase_login_app/models/user_avatars.dart';
import 'package:firebase_login_app/models/user_data.dart';
import 'package:firebase_login_app/models/users_model.dart';
import 'package:firebase_login_app/pages/authentication/authentication_page.dart';
import 'package:firebase_login_app/pages/home/account/account_info.dart';
import 'package:firebase_login_app/pages/home/account/editable_user_avatar.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:firebase_login_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.localize(LocKeys.account))),
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
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserAvatarWithButton(
                  userAvatar: UserAvatars.fromUserData(user),
                  iconData: Icons.edit,
                  onButtonPressed: () => _editAvatar(context, user),
                ),
                const SizedBox(height: 30),
                AccountInfo(user: user),
                const Expanded(child: SizedBox()),
                FilledButton(
                  onPressed: () async {
                    final shouldLogout = await Utils.showWarning(
                          context,
                          title: context.localize(LocKeys.logout),
                          content: context.localize(LocKeys.logoutWarning),
                          barrierDismissible: false,
                        ) ??
                        false;

                    if (shouldLogout && context.mounted) _logout(context);
                  },
                  child: Text(context.localize(LocKeys.logout).toUpperCase()),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void _editAvatar(BuildContext context, UserData user) {
    final avatars = <Widget>[];
    for (var entry in UserAvatars.avatars) {
      avatars.add(
        FloatingActionButton(
          onPressed: () {
            if (context.mounted) Navigator.of(context).pop();

            FirebaseFirestore.instance
                .collection('users')
                .doc(user.email)
                .update({
              'avatarName': entry.key,
            });
          },
          backgroundColor: Colors.white,
          child: UserAvatar(entry.value, radius: 24),
        ),
      );
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          context.localize(LocKeys.pickAvatar),
          textAlign: TextAlign.center,
        ),
        content: Wrap(
          alignment: WrapAlignment.center,
          spacing: 20,
          runSpacing: 20,
          children: avatars,
        ),
      ),
    );
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
}
