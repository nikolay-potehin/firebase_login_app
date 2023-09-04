import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/models/message_data.dart';
import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/pages/home/message/message_page_body.dart';
import 'package:firebase_login_app/repositories/messaging_repository.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage(
    this.messageDoc, {
    super.key,
  });

  final DocumentSnapshot<Map<String, dynamic>> messageDoc;

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
    final message = MessageData.fromDocument(widget.messageDoc);

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
      body: MessagePageBody(message: message),
    );
  }

  void _deleteMessage(BuildContext context) async {
    final shouldDelete = await Utils.showWarning(
          context,
          title: 'Delete this message?',
        ) ??
        false;

    if (shouldDelete && context.mounted) {
      await Utils.showLoading(
        context,
        MessagingRepository.deleteMessages([widget.messageDoc]),
      );

      if (context.mounted) Navigator.of(context).pop();
    }
  }
}
