import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/models/inbox_model.dart';
import 'package:firebase_login_app/pages/home/inbox/message_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<InboxModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
        actions: [
          IconButton(
            onPressed: model.deleteAllMessages,
            icon: const Icon(Icons.delete_outline),
          )
        ],
      ),
      body: Center(
        child: Consumer<InboxModel>(
          builder: (context, model, _) {
            final messages = model.receivedMessages;
            messages?.docs.sort((b, a) => (a.get('sendAtTime') as Timestamp)
                .compareTo(b.get('sendAtTime') as Timestamp));

            return messages == null
                ? const CircularProgressIndicator()
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: model.receivedMessages!.size,
                    itemBuilder: (context, index) {
                      final doc = model.receivedMessages!.docs[index];

                      return MessageTile(doc: doc);
                    },
                  );
          },
        ),
      ),
    );
  }
}
