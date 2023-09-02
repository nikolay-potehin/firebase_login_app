import 'package:cloud_firestore/cloud_firestore.dart';

class MessageData {
  MessageData({
    required this.fromEmail,
    required this.fromUsername,
    required this.toEmail,
    required this.title,
    required this.content,
    required this.isUnread,
    Timestamp? sendAtTime,
  }) : sendAtTime = sendAtTime ?? Timestamp.now();

  final String title;
  final String content;
  final String fromEmail;
  final String toEmail;
  final String? fromUsername;
  final Timestamp sendAtTime;
  final bool isUnread;

  factory MessageData.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;

    return MessageData(
      fromEmail: json['fromEmail'],
      toEmail: json['toEmail'],
      title: json['title'],
      content: json['content'],
      sendAtTime: json['sendAtTime'],
      isUnread: json['isUnread'] ?? false,
      fromUsername: json['fromUsername'],
    );
  }

  Map<String, dynamic> toJson() => {
        'fromEmail': fromEmail,
        'fromUsername': fromUsername,
        'toEmail': toEmail,
        'title': title,
        'content': content,
        'sendAtTime': sendAtTime,
        'isUnread': isUnread,
      };
}
