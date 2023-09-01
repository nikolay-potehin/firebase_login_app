import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/extensions/timestamp_extensions.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  MessageTile({
    super.key,
    required this.emailDoc,
    required this.onTap,
  })  : title = emailDoc.get('title') as String,
        content = emailDoc.get('content') as String,
        fromEmail = emailDoc.get('fromEmail') as String,
        toEmail = emailDoc.get('toEmail') as String,
        sendAtTime = emailDoc.get('sendAtTime') as Timestamp,
        isUnread = emailDoc.data()['isUnread'] ?? false;

  final QueryDocumentSnapshot<Map<String, dynamic>> emailDoc;
  final VoidCallback onTap;
  final String title;
  final String content;
  final String fromEmail;
  final String toEmail;
  final Timestamp sendAtTime;
  final bool isUnread;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(title),
        subtitle: Text(
          sendAtTime.toTimeString(),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: isUnread ? const _UnreadBadge() : null,
      ),
    );
  }
}

class _UnreadBadge extends StatelessWidget {
  const _UnreadBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.red,
      ),
      child: const Text(
        'New',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
