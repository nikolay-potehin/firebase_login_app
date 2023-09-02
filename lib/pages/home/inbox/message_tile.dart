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

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Colors.grey.shade200,
        ),
        child: ListTile(
          title: Row(
            children: [
              Text(
                message.fromUser.displayName,
                overflow: TextOverflow.ellipsis,
              ),
              const Expanded(child: SizedBox()),
              Text(message.sendAtTime.toShortTimeString()),
            ],
          ),
          subtitle: Text(message.title, overflow: TextOverflow.ellipsis),
          trailing: message.isUnread ? const _UnreadChip() : null,
        ),
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
