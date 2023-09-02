import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/models/user_data.dart';

class MessageData {
  MessageData({
    required this.fromUser,
    required this.toEmail,
    required this.title,
    required this.content,
    required this.isUnread,
    Timestamp? sendAtTime,
  }) : sendAtTime = sendAtTime ?? Timestamp.now();

  final UserData fromUser;
  final String title;
  final String content;
  final String toEmail;
  final Timestamp sendAtTime;
  final bool isUnread;

  factory MessageData.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;

    return MessageData(
      fromUser: UserData.fromJson(json['fromUser']),
      toEmail: json['toEmail'],
      title: json['title'],
      content: json['content'],
      sendAtTime: json['sendAtTime'],
      isUnread: json['isUnread'],
    );
  }

  Map<String, dynamic> toJson() => {
        'fromUser': fromUser.toJson(),
        'toEmail': toEmail,
        'title': title,
        'content': content,
        'sendAtTime': sendAtTime,
        'isUnread': isUnread,
      };
}
