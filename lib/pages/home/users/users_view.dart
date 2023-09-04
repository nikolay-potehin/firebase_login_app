import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/pages/home/users/user_tile.dart';
import 'package:flutter/material.dart';

class UsersView extends StatelessWidget {
  const UsersView({
    super.key,
    required this.users,
  });

  final List<DocumentSnapshot<Map<String, dynamic>>>? users;

  @override
  Widget build(BuildContext context) {
    if (users == null) return const CircularProgressIndicator();

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: users!.length,
      itemBuilder: (context, index) => UserTile(userDoc: users![index]),
      separatorBuilder: (context, index) => const SizedBox(height: 4),
    );
  }
}
