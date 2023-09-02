import 'package:firebase_login_app/components/user_avatar.dart';
import 'package:firebase_login_app/extensions/timestamp_extensions.dart';
import 'package:firebase_login_app/models/message_data.dart';
import 'package:firebase_login_app/models/user_avatars.dart';
import 'package:firebase_login_app/models/user_data.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class UserInfoCard extends StatefulWidget {
  const UserInfoCard({
    super.key,
    required this.fromUser,
    required this.message,
  });

  final UserData fromUser;
  final MessageData message;

  @override
  State<UserInfoCard> createState() => _UserInfoCardState();
}

class _UserInfoCardState extends State<UserInfoCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAvatar(UserAvatars.fromUserData(widget.fromUser)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.fromUser.displayName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'to: you (${widget.message.toEmail})',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: () => setState(() => isExpanded = !isExpanded),
              icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
            ),
          ],
        ),
        if (isExpanded)
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black),
            ),
            child: Column(
              children: [
                _InfoRow(
                  'From:',
                  widget.fromUser.displayName,
                  widget.fromUser.email,
                ),
                const SizedBox(height: 8),
                _InfoRow(
                  'To:',
                  UserRepository.user!.displayName!,
                  UserRepository.user!.email!,
                ),
                const SizedBox(height: 8),
                _InfoRow(
                  'Date:',
                  widget.message.sendAtTime.toTimeString(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.title, this.value1, [this.value2]);

  final String title;
  final String value1;
  final String? value2;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 45, child: Text(title)),
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(value1),
              if (value2 != null) ...[
                const SizedBox(width: 4),
                const Icon(Icons.circle, size: 5),
                const SizedBox(width: 4),
                Text(value2!),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
