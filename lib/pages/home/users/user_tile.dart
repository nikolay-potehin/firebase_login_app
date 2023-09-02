import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/components/user_avatar.dart';
import 'package:firebase_login_app/models/user_avatars.dart';
import 'package:firebase_login_app/models/user_data.dart';
import 'package:firebase_login_app/pages/home/user_profile/user_profile_page.dart';
import 'package:firebase_login_app/pages/home/write_message/write_message_page.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:firebase_login_app/theme.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.userDoc,
  });

  final QueryDocumentSnapshot<Map<String, dynamic>> userDoc;

  @override
  Widget build(BuildContext context) {
    final user = UserData.fromDocument(userDoc);
    final isCurrentUser = user.email == UserRepository.user?.email;

    return Card(
      child: ListTile(
        enabled: !isCurrentUser,
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UserProfilePage(user: user),
        )),
        title: Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          children: [
            Text(isCurrentUser ? '(You) ${user.displayName}' : user.displayName)
          ],
        ),
        subtitle: Text(user.email),
        leading: UserAvatar(UserAvatars.fromUserData(user)),
        trailing: IconButton(
          constraints: const BoxConstraints(),
          onPressed: isCurrentUser
              ? null
              : () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => WriteMessagePage(
                      userData: UserData.fromDocument(userDoc),
                    ),
                  )),
          icon: Icon(
            Icons.email,
            color: isCurrentUser ? myPrimarySwatch.shade200 : myPrimarySwatch,
          ),
        ),
      ),
    );
  }
}
