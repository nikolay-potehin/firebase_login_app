import 'package:firebase_login_app/models/user_avatars.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar(
    this.userAvatar, {
    super.key,
    this.radius = 20,
  });

  factory UserAvatar.big(UserAvatarData userAvatar) => UserAvatar(
        userAvatar,
        radius: 60,
      );

  final double radius;
  final UserAvatarData userAvatar;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: userAvatar.backgroundColor,
      child: Icon(
        userAvatar.iconData,
        size: radius * 1.2,
        color: Colors.white,
      ),
    );
  }
}
