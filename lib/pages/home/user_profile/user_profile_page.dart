import 'package:firebase_login_app/models/user_avatars.dart';
import 'package:firebase_login_app/models/user_data.dart';
import 'package:firebase_login_app/pages/home/account/account_info.dart';
import 'package:firebase_login_app/pages/home/account/editable_user_avatar.dart';
import 'package:firebase_login_app/pages/home/write_message/write_message_page.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({
    super.key,
    required this.user,
  });

  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.displayName)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
          child: Column(
            children: [
              UserAvatarWithButton(
                userAvatar: UserAvatars.fromUserData(user),
                iconData: Icons.mail,
                onButtonPressed: () =>
                    Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WriteMessagePage(toUser: user),
                )),
              ),
              const SizedBox(height: 30),
              AccountInfo(user: user),
            ],
          ),
        ),
      ),
    );
  }
}
