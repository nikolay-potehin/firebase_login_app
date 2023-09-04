import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/components/user_avatar.dart';
import 'package:firebase_login_app/extensions/timestamp_extensions.dart';
import 'package:firebase_login_app/models/inbox_appbar_manager.dart';
import 'package:firebase_login_app/models/message_data.dart';
import 'package:firebase_login_app/models/user_avatars.dart';
import 'package:firebase_login_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageTile extends StatefulWidget {
  const MessageTile({
    super.key,
    required this.messageDoc,
    required this.onTap,
    this.asSended = false,
  });

  final DocumentSnapshot<Map<String, dynamic>> messageDoc;
  final VoidCallback onTap;
  final bool asSended;

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    final messageData = MessageData.fromDocument(widget.messageDoc);
    final fontWeight =
        messageData.isUnread ? FontWeight.bold : FontWeight.normal;
    final manager = context.read<InboxAppbarManager>();
    final isSelected = manager.isSelected(message: widget.messageDoc);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        onTap: () => isSelected
            ? manager.toggle(message: widget.messageDoc)
            : widget.onTap(),
        onLongPress: () => manager.toggle(message: widget.messageDoc),
        highlightColor: myPrimarySwatch.shade200,
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            color: isSelected ? myPrimarySwatch.shade100 : Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(messageData, isSelected, widget.asSended),
              const SizedBox(width: 16),
              _tileContent(messageData, fontWeight, widget.asSended),
              _tileDate(messageData, fontWeight),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(MessageData message, bool isSelected, bool asSended) {
    if (isSelected) {
      return CircleAvatar(
        backgroundColor: myPrimarySwatch.shade400,
        child: const Icon(Icons.done, color: Colors.white),
      );
    } else {
      final user = asSended ? message.toUser : message.fromUser;
      return UserAvatar(UserAvatars.fromUserData(user));
    }
  }

  SizedBox _tileDate(MessageData message, FontWeight fontWeight) {
    return SizedBox(
      width: 50,
      child: Column(
        children: [
          Text(
            message.sendAtTime.toShortTimeString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: fontWeight,
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Expanded _tileContent(
    MessageData message,
    FontWeight fontWeight,
    bool asSended,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            asSended
                ? 'To: ${message.toUser.displayName}'
                : message.fromUser.displayName,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: fontWeight,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            message.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: fontWeight,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            message.content,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
