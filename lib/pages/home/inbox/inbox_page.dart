import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/extensions/string_extensions.dart';
import 'package:firebase_login_app/models/inbox_model.dart';
import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/pages/home/inbox/empty_inbox_widget.dart';
import 'package:firebase_login_app/pages/home/inbox/inbox_drawer.dart';
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
        actions: const [
          // IconButton(
          //   onPressed: () => _deleteAllMessages(context),
          //   icon: const Icon(Icons.delete_forever),
          // )
        ],
      ),
      drawer: const InboxDrawer(),
      body: Center(
        child: Consumer<InboxModel>(
          builder: (context, inbox, _) {
            final messages = inbox.messages;

            if (messages == null) return const CircularProgressIndicator();

            if (messages.isEmpty) return EmptyInboxWidget(filter: inbox.filter);

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: messages.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) return _FolderNameWidget(inbox.filter);
                final messageDoc = messages[index - 1];

                return MessageTile(
                  messageDoc: messageDoc,
                  onTap: () => _openMessage(context, messageDoc),
                  asSended: inbox.filter == Messages.sended,
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

class _FolderNameWidget extends StatelessWidget {
  const _FolderNameWidget(this.filter);

  final Messages filter;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: const BoxDecoration(),
      child: Text(
        filter.name.capitalize(),
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }
}
