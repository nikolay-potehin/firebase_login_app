import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/extensions/timestamp_extensions.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  MessageTile({
    super.key,
    required this.doc,
    required this.onTap,
  })  : title = doc.get('title') as String,
        content = doc.get('content') as String,
        fromEmail = doc.get('fromEmail') as String,
        toEmail = doc.get('toEmail') as String,
        sendAtTime = doc.get('sendAtTime') as Timestamp;

  final QueryDocumentSnapshot<Map<String, dynamic>> doc;
  final VoidCallback onTap;
  final String title;
  final String content;
  final String fromEmail;
  final String toEmail;
  final Timestamp sendAtTime;

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
        trailing: Text(fromEmail),
      ),
    );
  }
}