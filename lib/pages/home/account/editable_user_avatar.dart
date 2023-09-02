import 'package:firebase_login_app/components/user_avatar.dart';
import 'package:firebase_login_app/models/user_avatars.dart';
import 'package:flutter/material.dart';

class UserAvatarWithButton extends StatelessWidget {
  const UserAvatarWithButton({
    required this.userAvatar,
    required this.iconData,
    required this.onButtonPressed,
    super.key,
  });

  final UserAvatarData userAvatar;
  final IconData iconData;
  final VoidCallback? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        UserAvatar.big(userAvatar),
        FloatingActionButton.small(
          onPressed: onButtonPressed,
          foregroundColor: Colors.white,
          child: Icon(iconData),
        ),
      ],
    );
  }
}
