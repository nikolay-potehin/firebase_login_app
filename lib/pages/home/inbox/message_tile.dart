import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/extensions/timestamp_extensions.dart';
import 'package:firebase_login_app/models/message_data.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({
    super.key,
    required this.emailDoc,
    required this.onTap,
  });

  final QueryDocumentSnapshot<Map<String, dynamic>> emailDoc;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final message = MessageData.fromDocument(emailDoc);

    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(message.title),
        subtitle: Text(
          message.sendAtTime.toTimeString(),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: message.isUnread ? const _UnreadChip() : null,
      ),
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
