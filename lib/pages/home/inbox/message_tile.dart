import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/components/user_avatar.dart';
import 'package:firebase_login_app/extensions/timestamp_extensions.dart';
import 'package:firebase_login_app/models/message_data.dart';
import 'package:firebase_login_app/models/user_avatars.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({
    super.key,
    required this.messageDoc,
    required this.onTap,
  });

  final QueryDocumentSnapshot<Map<String, dynamic>> messageDoc;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final message = MessageData.fromDocument(messageDoc);
    final fontWeight = message.isUnread ? FontWeight.bold : FontWeight.normal;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      decoration: const BoxDecoration(),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAvatar(UserAvatars.fromUserData(message.fromUser)),
              const SizedBox(width: 16),
              _tileContent(message, fontWeight),
              _tileDate(message, fontWeight),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _tileDate(MessageData message, FontWeight fontWeight) {
    return SizedBox(
      width: 50,
      child: Column(
        children: [
          Text(
            message.sendAtTime.toShortTimeString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: fontWeight,
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Expanded _tileContent(MessageData message, FontWeight fontWeight) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.fromUser.displayName,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: fontWeight,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            message.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: fontWeight,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            message.content,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
