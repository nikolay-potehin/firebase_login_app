import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/models/user_data.dart';
import 'package:firebase_login_app/models/utils.dart';
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
        onTap: () => Utils.showSnackBar('This is ${user.displayName}'),
        title: Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          children: [
            Text(isCurrentUser ? '(You) ${user.displayName}' : user.displayName)
          ],
        ),
        subtitle: Text(user.email),
        leading: const CircleAvatar(child: Icon(Icons.person)),
        trailing: IconButton(
          constraints: const BoxConstraints(),
          onPressed: isCurrentUser
              ? null
              : () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => WriteMessagePage(userDoc: userDoc),
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
