import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class UsersModel extends ChangeNotifier {
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _stream;
  late final StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      _streamSubscription;
  QuerySnapshot<Map<String, dynamic>>? users;

  late final Stream<DocumentSnapshot<Map<String, dynamic>>> _currentUserStream;
  late final StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>
      _currentUserStreamSubscription;
  DocumentSnapshot<Map<String, dynamic>>? currentUser;

  UsersModel() {
    _stream = FirebaseFirestore.instance
        .collection('users')
        .orderBy('creationTime', descending: true)
        .snapshots();

    _streamSubscription = _stream.listen((snapshot) {
      users = snapshot;
      notifyListeners();
    });

    _currentUserStream = FirebaseFirestore.instance
        .collection('users')
        .doc(UserRepository.user!.email)
        .snapshots();

    _currentUserStreamSubscription = _currentUserStream.listen((snapshot) {
      currentUser = snapshot;
      notifyListeners();
    });
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserByEmail(
      String email) {
    return FirebaseFirestore.instance.collection('users').doc(email).get();
  }

  void cancel() {
    _streamSubscription.cancel();
    _currentUserStreamSubscription.cancel();
  }
}
