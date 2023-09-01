import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/pages/home/write_message/write_message_page.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:firebase_login_app/theme.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  UserTile({
    super.key,
    required this.userDoc,
  })  : email = userDoc.get('email') as String,
        displayName = userDoc.get('displayName') as String;

  final QueryDocumentSnapshot<Map<String, dynamic>> userDoc;
  final String displayName;
  final String email;

  bool get isCurrentUser => email == UserRepository.user?.email;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        enabled: !isCurrentUser,
        onTap: () => Utils.showSnackBar('This is $displayName'),
        title: Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          children: [Text(isCurrentUser ? '(You) $displayName' : displayName)],
        ),
        subtitle: Text(email),
        leading: const CircleAvatar(),
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
