import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/extensions/timestamp_extensions.dart';
import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/theme.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  MessagePage(
    this.doc, {
    super.key,
  })  : title = doc.get('title'),
        content = doc.get('content'),
        fromEmail = doc.get('fromEmail'),
        sendAtTime = doc.get('sendAtTime');

  final DocumentSnapshot<Map<String, dynamic>> doc;
  final String title;
  final String content;
  final String fromEmail;
  final Timestamp sendAtTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
        actions: [
          IconButton(
            onPressed: () => _deleteMessage(context),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 4),
            Text(
              'from: $fromEmail',
              style: TextStyle(
                fontSize: 16,
                color: myPrimarySwatch,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(content, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 40),
            Text(
              sendAtTime.toTimeString(),
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteMessage(BuildContext context) async {
    final shouldDelete = await Utils.showWarning(
          context,
          title: 'Delete this message?',
        ) ??
        false;

    if (shouldDelete) {
      await doc.reference.delete();
      if (context.mounted) Navigator.of(context).pop();
    }
  }
}
