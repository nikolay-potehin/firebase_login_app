import 'package:firebase_login_app/models/user_data.dart';
import 'package:firebase_login_app/theme.dart';
import 'package:flutter/material.dart';

class UserAvatars {
  static final _avatars = {
    'person': UserAvatarData(
      iconData: Icons.person,
      backgroundColor: myPrimarySwatch.shade300,
    ),
    'person_2': UserAvatarData(
      iconData: Icons.person_2,
      backgroundColor: Colors.amber.shade300,
    ),
    'person_3': UserAvatarData(
      iconData: Icons.person_3,
      backgroundColor: Colors.pink.shade300,
    ),
    'person_4': UserAvatarData(
      iconData: Icons.person_4,
      backgroundColor: Colors.blue.shade300,
    ),
    'pets': UserAvatarData(
      iconData: Icons.pets,
      backgroundColor: Colors.purple.shade300,
    ),
    'coffee': UserAvatarData(
      iconData: Icons.coffee,
      backgroundColor: Colors.brown.shade300,
    ),
    'developer': UserAvatarData(
      iconData: Icons.view_in_ar_rounded,
      backgroundColor: Colors.blueGrey.shade300,
    ),
    'admin': UserAvatarData(
      iconData: Icons.manage_accounts,
      backgroundColor: Colors.indigo.shade300,
    ),
  };

  static final _secureNames = ['admin', 'developer'];

  static Iterable<MapEntry<String, UserAvatarData>> get avatars =>
      _avatars.entries.where((element) => !_secureNames.contains(element.key));

  static UserAvatarData get person => _avatars.values.first;

  static UserAvatarData avatarData(String? name) => _avatars[name] ?? person;

  static UserAvatarData fromUserData(UserData user) =>
      avatarData(user.avatarName);
}

class UserAvatarData {
  final IconData iconData;
  final Color? backgroundColor;

  const UserAvatarData({
    required this.iconData,
    this.backgroundColor,
  });
}
