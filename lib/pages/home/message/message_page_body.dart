import 'package:firebase_login_app/models/message_data.dart';
import 'package:firebase_login_app/pages/home/message/expandable_message_info_card.dart';
import 'package:firebase_login_app/pages/home/write_message/write_message_page.dart';
import 'package:flutter/material.dart';

class MessagePageBody extends StatelessWidget {
  const MessagePageBody({
    super.key,
    required this.message,
  });

  final MessageData message;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message.title, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpandableMessageInfoCard(
                message: message,
                onReplyPressed: () =>
                    Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WriteMessagePage(
                    toUser: message.fromUser,
                  ),
                )),
              ),
              const SizedBox(height: 20),
              Text(message.content, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }
}
