import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/extensions/timestamp_extensions.dart';
import 'package:firebase_login_app/models/message_data.dart';
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

    return ListTile(
      onTap: onTap,
      title: Text(message.fromUsername ?? message.fromEmail,
          overflow: TextOverflow.ellipsis),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message.title, overflow: TextOverflow.ellipsis),
          Text(
            message.sendAtTime.toShortTimeString(),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      trailing: message.isUnread ? const _UnreadChip() : null,
    );
  }
}

class _UnreadChip extends StatelessWidget {
  const _UnreadChip();

  @override
  Widget build(BuildContext context) {
    return const Chip(
      backgroundColor: Colors.red,
      elevation: 2,
      label: Text('New'),
      labelStyle: TextStyle(color: Colors.white),
    );
  }
}
