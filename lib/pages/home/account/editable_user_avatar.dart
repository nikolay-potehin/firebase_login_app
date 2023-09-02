import 'package:firebase_login_app/components/user_avatar.dart';
import 'package:firebase_login_app/models/user_avatars.dart';
import 'package:flutter/material.dart';

class EditableUserAvatar extends StatelessWidget {
  const EditableUserAvatar({
    required this.userAvatar,
    required this.onEditPressed,
    super.key,
  });

  final UserAvatarData userAvatar;
  final VoidCallback? onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        UserAvatar.big(userAvatar),
        FloatingActionButton.small(
          onPressed: onEditPressed,
          foregroundColor: Colors.white,
          child: const Icon(Icons.edit),
        ),
      ],
    );
  }
}
