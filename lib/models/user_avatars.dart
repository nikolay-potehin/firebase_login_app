import 'package:firebase_login_app/models/user_data.dart';
import 'package:firebase_login_app/theme.dart';
import 'package:flutter/material.dart';

class UserAvatars {
  static final avatars = {
    'person': UserAvatarData(
      iconData: Icons.person,
      backgroundColor: myPrimarySwatch.shade300,
    ),
    'admin': const UserAvatarData(
      iconData: Icons.support_agent_rounded,
      backgroundColor: Colors.blue,
    ),
  };

  static UserAvatarData get person => avatars.values.first;

  static UserAvatarData avatarData(String? name) => avatars[name] ?? person;

  static UserAvatarData fromUserData(UserData user) =>
      avatarData(user.avatarName);
}

class UserAvatarData {
  const UserAvatarData({
    required this.iconData,
    this.backgroundColor,
  });

  final IconData iconData;
  final Color? backgroundColor;
}
