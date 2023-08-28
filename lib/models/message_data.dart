import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/pages/home/message/message_page.dart';
import 'package:flutter/material.dart';

class MessageData {
  final String title;
  final String content;
  final Timestamp sendAtTime;

  MessageData({
    required this.title,
    required this.content,
    Timestamp? sendAtTime,
  }) : sendAtTime = sendAtTime ?? Timestamp.now();

  factory MessageData.fromJson(Map<String, dynamic> json) => MessageData(
        title: json['title'],
        content: json['content'],
        sendAtTime: json['sendAtTime'],
      );

  Widget asWidget(BuildContext context) => Card(
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MessagePage(this),
            ));
          },
          title: Text(title),
          subtitle: Text(
            sendAtTime.toDate().toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'sendAtTime': sendAtTime,
      };
}
