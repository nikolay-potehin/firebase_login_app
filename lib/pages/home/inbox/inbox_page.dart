import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/models/inbox_model.dart';
import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/pages/home/inbox/empty_inbox_widget.dart';
import 'package:firebase_login_app/pages/home/inbox/message_tile.dart';
import 'package:firebase_login_app/pages/home/message/message_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
        actions: [
          IconButton(
            onPressed: () => _deleteAllMessages(context),
            icon: const Icon(Icons.delete_forever),
          )
        ],
      ),
      body: Center(
        child: Consumer<InboxModel>(
          builder: (context, model, _) {
            final length = model.receivedMessages?.size;
            final messages = model.receivedMessages?.docs;

            if (messages == null) return const CircularProgressIndicator();

            if (messages.isEmpty) return const EmptyInboxWidget();

            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: length,
              itemBuilder: (context, index) {
                final doc = messages[index];

                return MessageTile(
                  doc: doc,
                  onTap: () => _openMessage(context, doc),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _openMessage(
    BuildContext context,
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MessagePage(doc),
    ));
  }

  void _deleteAllMessages(BuildContext context) async {
    final shouldDelete = await Utils.showWarning(
          context,
          title: 'Delete All Messages',
          content:
              'You are about to delete all of your messages. Are you sure?',
        ) ??
        false;

    if (shouldDelete && context.mounted) {
      context.read<InboxModel>().deleteAllMessages();
    }
  }
}
