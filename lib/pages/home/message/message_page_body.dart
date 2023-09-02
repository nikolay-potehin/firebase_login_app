import 'package:firebase_login_app/models/message_data.dart';
import 'package:firebase_login_app/models/user_data.dart';
import 'package:firebase_login_app/models/users_model.dart';
import 'package:firebase_login_app/pages/home/message/user_info_card.dart';
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
          FutureBuilder(
            future: UsersModel.getUserByEmail(
              message.fromEmail,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final fromUser = UserData.fromDocument(snapshot.data!);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserInfoCard(fromUser: fromUser, message: message),
                    const SizedBox(height: 20),
                    Text(message.content, style: const TextStyle(fontSize: 18)),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
