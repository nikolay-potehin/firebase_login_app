import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/models/message_data.dart';
import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/repositories/firestore_repository.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class UsersModel extends ChangeNotifier {
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _stream;
  late final StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      _streamSubscription;
  QuerySnapshot<Map<String, dynamic>>? users;

  UsersModel() {
    _stream = FirebaseFirestore.instance
        .collection('users')
        .orderBy('creationTime', descending: true)
        .snapshots();

    _streamSubscription = _stream.listen((snapshot) {
      users = snapshot;
      notifyListeners();
    });
  }

  void cancel() => _streamSubscription.cancel();

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
