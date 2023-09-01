import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
}
