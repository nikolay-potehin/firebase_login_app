import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class InboxModel extends ChangeNotifier {
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _stream;
  QuerySnapshot<Map<String, dynamic>>? receivedMessages;

  InboxModel() {
    _stream = FirebaseFirestore.instance
        .collection('users')
        .doc(UserRepository.user!.email)
        .collection('messages')
        .snapshots();

    _stream.listen((snapshot) {
      receivedMessages = snapshot;
      notifyListeners();
    });
  }

  void deleteAllMessages() async {
    // TODO: change to bacth/transaction
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(UserRepository.user!.email)
        .collection('messages')
        .get()
        .then((collection) {
      for (final doc in collection.docs) {
        doc.reference.delete();
      }
    });
  }
}
