import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/extensions/timestamp_extensions.dart';
import 'package:firebase_login_app/pages/home/message/message_page.dart';
import 'package:flutter/material.dart';

class MessageData {
  final String title;
  final String content;
  final String fromEmail;
  final String toEmail;
  final Timestamp sendAtTime;

  MessageData({
    required this.fromEmail,
    required this.toEmail,
    required this.title,
    required this.content,
    Timestamp? sendAtTime,
  }) : sendAtTime = sendAtTime ?? Timestamp.now();

  factory MessageData.fromJson(Map<String, dynamic> json) => MessageData(
        fromEmail: json['fromEmail'],
        toEmail: json['toEmail'],
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
            sendAtTime.toTimeString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        'fromEmail': fromEmail,
        'toEmail': toEmail,
        'title': title,
        'content': content,
        'sendAtTime': sendAtTime,
      };
}
