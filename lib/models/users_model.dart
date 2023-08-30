import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/models/message_data.dart';
import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/repositories/firestore_repository.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class UsersModel extends ChangeNotifier {
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _stream;
  QuerySnapshot<Map<String, dynamic>>? users;

  UsersModel() {
    _stream = FirebaseFirestore.instance.collection('users').snapshots();

    _stream.listen((snapshot) {
      users = snapshot;
      notifyListeners();
      print('users notified!');
    });
  }

  void sendMessage(String recipientEmail) async {
    FirestoreRepository.sendMessage(MessageData(
      fromEmail: UserRepository.user!.email!,
      toEmail: recipientEmail,
      title: 'New Message',
      content: 'Message content',
    ));
    Utils.showSnackBar('Message sent to "$recipientEmail"');
  }
}
