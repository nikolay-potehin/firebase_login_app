import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:firebase_login_app/theme.dart';
import 'package:flutter/material.dart';

class UserData {
  final String email;
  final String? displayName;
  final Timestamp? creationTime;
  final Timestamp? lastSingInTime;

  UserData({
    required this.email,
    this.displayName,
    this.creationTime,
    this.lastSingInTime,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        email: json['email'],
        displayName: json['displayName'],
        creationTime: json['creationTime'],
        lastSingInTime: json['lastSignInTime'],
      );

  String get lastSignInDisplayTime =>
      lastSingInTime?.toDate().toIso8601String() ?? 'Nobody knows when...';

  bool get isCurrentUser => email == UserRepository.user?.email;

  Widget buildTitle() {
    String result = isCurrentUser ? '(You) ' : '';
    result += displayName != null ? displayName! : email;

    return Text(result);
  }

  Widget asWidget({required VoidCallback onTap}) => Card(
        child: ListTile(
          enabled: !isCurrentUser,
          onTap: () => Utils.showSnackBar('This is ${displayName ?? email}'),
          title: buildTitle(),
          subtitle: displayName != null ? Text(email) : null,
          leading: const CircleAvatar(),
          trailing: IconButton(
            constraints: const BoxConstraints(),
            onPressed: isCurrentUser ? null : onTap,
            icon: Icon(
              Icons.email,
              color: isCurrentUser ? myPrimarySwatch.shade200 : myPrimarySwatch,
            ),
          ),
        ),
      );
}
