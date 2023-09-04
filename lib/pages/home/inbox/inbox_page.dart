import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/models/inbox_appbar_manager.dart';
import 'package:firebase_login_app/models/inbox_model.dart';
import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/pages/home/inbox/empty_inbox_widget.dart';
import 'package:firebase_login_app/pages/home/inbox/folder_name_widget.dart';
import 'package:firebase_login_app/pages/home/inbox/inbox_drawer.dart';
import 'package:firebase_login_app/pages/home/inbox/message_tile.dart';
import 'package:firebase_login_app/pages/home/message/message_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    final inboxManager = context.watch<InboxAppbarManager>();

    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: inboxManager.isActive ? null : const InboxDrawer(),
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
                if (index == 0) return FolderNameWidget(inbox.filter);
                final messageDoc = messages[index - 1];

                return MessageTile(
                  messageDoc: messageDoc,
                  onTap: () {
                    final manager = context.read<InboxAppbarManager>();
                    if (manager.isActive) {
                      manager.unselectAll();
                    } else {
                      _openMessage(context, messageDoc);
                    }
                  },
                  asSended: inbox.filter == Messages.sended,
                );
              },
            );
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final manager = context.read<InboxAppbarManager>();
    final isActive = manager.isActive;

    return AppBar(
      // backgroundColor: isActive ? Colors.white : null,
      // foregroundColor: isActive ? Colors.black87 : null,
      title: Text(isActive ? 'Selected: ${manager.countSelected}' : 'Inbox'),
      leading: isActive
          ? IconButton(
              onPressed: () => manager.unselectAll(),
              icon: const Icon(Icons.arrow_back),
            )
          : null,
      actions: [
        if (isActive)
          IconButton(
            onPressed: () => _deleteSelectedMessages(context),
            icon: const Icon(Icons.delete),
          ),
      ],
    );
  }

  void _deleteSelectedMessages(BuildContext context) async {
    final manager = context.read<InboxAppbarManager>();
    final shouldDelete = await Utils.showWarning(
          context,
          title: 'Delete selected messages?',
          content:
              'You are about to delete all selected messages. Are you sure?',
        ) ??
        false;

    if (shouldDelete && context.mounted) {
      Utils.showLoading(context, manager.deleteSelectedMessages());
    }
  }

  void _openMessage(
    BuildContext context,
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MessagePage(doc),
    ));
  }
}
