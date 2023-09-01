import 'package:cloud_firestore/cloud_firestore.dart';

class MessageData {
  MessageData({
    required this.fromEmail,
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
    );
  }

  Map<String, dynamic> toJson() => {
        'fromEmail': fromEmail,
        'toEmail': toEmail,
        'title': title,
        'content': content,
        'sendAtTime': sendAtTime,
        'isUnread': isUnread,
      };
}
