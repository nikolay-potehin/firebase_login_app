import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/models/user_data.dart';

class MessageData {
  MessageData({
    required this.fromUser,
    required this.toUser,
    required this.title,
    required this.content,
    required this.isUnread,
    Timestamp? sendAtTime,
  }) : sendAtTime = sendAtTime ?? Timestamp.now();

  final UserData fromUser;
  final UserData toUser;
  final String title;
  final String content;
  final Timestamp sendAtTime;
  final bool isUnread;

  factory MessageData.asSended(MessageData message) => MessageData(
        fromUser: message.fromUser,
        toUser: message.toUser,
        title: message.title,
        content: message.content,
        isUnread: false,
      );

  factory MessageData.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;
    print(json);

    return MessageData(
      fromUser: UserData.fromJson(json['fromUser']),
      toUser: UserData.fromJson(json['toUser']),
      title: json['title'],
      content: json['content'],
      sendAtTime: json['sendAtTime'],
      isUnread: json['isUnread'],
    );
  }

  Map<String, dynamic> toJson() => {
        'fromUser': fromUser.toJson(),
        'toUser': toUser.toJson(),
        'title': title,
        'content': content,
        'sendAtTime': sendAtTime,
        'isUnread': isUnread,
      };
}
