import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/extensions/timestamp_extensions.dart';
import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/theme.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  MessagePage(
    this.messageDoc, {
    super.key,
  })  : title = messageDoc.get('title'),
        content = messageDoc.get('content'),
        fromEmail = messageDoc.get('fromEmail'),
        sendAtTime = messageDoc.get('sendAtTime');

  final DocumentSnapshot<Map<String, dynamic>> messageDoc;
  final String title;
  final String content;
  final String fromEmail;
  final Timestamp sendAtTime;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  void initState() {
    super.initState();
    widget.messageDoc.reference.update({'isUnread': false});
  }

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
            Text(widget.title, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 4),
            Text(
              'from: ${widget.fromEmail}',
              style: TextStyle(
                fontSize: 16,
                color: myPrimarySwatch,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(widget.content, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 40),
            Text(
              widget.sendAtTime.toTimeString(),
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
      await widget.messageDoc.reference.delete();
      if (context.mounted) Navigator.of(context).pop();
    }
  }
}
