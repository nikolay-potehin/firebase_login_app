import 'package:firebase_login_app/extensions/int_extenstions.dart';
import 'package:firebase_login_app/models/inbox_model.dart';
import 'package:firebase_login_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InboxDrawer extends StatelessWidget {
  const InboxDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InboxModel>(
      builder: (context, inbox, _) {
        return const Drawer(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DrawerTitle(),
                  Divider(),
                  _DrawerTile(
                    filter: Messages.received,
                    iconData: Icons.inbox_rounded,
                    title: 'Received',
                  ),
                  Divider(),
                  _DrawerTile(
                    filter: Messages.unread,
                    iconData: Icons.mark_email_unread_outlined,
                    title: 'Unread',
                  ),
                  _DrawerTile(
                    filter: Messages.sended,
                    iconData: Icons.send_outlined,
                    title: 'Sended',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.filter,
    required this.iconData,
    required this.title,
  });

  final Messages filter;
  final IconData iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    final inbox = context.read<InboxModel>();
    final count = inbox.messagesCounter[filter];

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ListTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
        ),
        selectedColor: Colors.black,
        selectedTileColor: myPrimarySwatch.shade200,
        selected: inbox.filter == filter,
        onTap: () {
          inbox.setFilter(filter);
          Navigator.of(context).pop();
        },
        minLeadingWidth: 30,
        leading: Icon(
          iconData,
          color: Colors.black,
        ),
        title: Text(title),
        trailing: count == null ? null : Text(count.toCountString()),
      ),
    );
  }
}

class _DrawerTitle extends StatelessWidget {
  const _DrawerTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10),
      child: Text(
        'Green Box',
        style: TextStyle(
          fontSize: 20,
          color: myPrimarySwatch,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
