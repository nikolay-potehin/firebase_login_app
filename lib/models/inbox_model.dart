import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';

enum Messages { sended, received, unread }

class InboxModel extends ChangeNotifier {
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _receivedMsgStream;
  late final StreamSubscription _receivedMsgSubscription;
  List<DocumentSnapshot<Map<String, dynamic>>>? _receivedMessages;

  late final Stream<QuerySnapshot<Map<String, dynamic>>> _sendedMsgStream;
  late final StreamSubscription _sendedMsgSubscription;
  List<DocumentSnapshot<Map<String, dynamic>>>? _sendedMessages;

  final Map<Messages, int?> _messagesCounter = {};
  Map<Messages, int?> get messagesCounter => _messagesCounter;

  Messages _messageFilter = Messages.received;
  Messages get filter => _messageFilter;

  InboxModel() {
    _receivedMsgStream = FirebaseFirestore.instance
        .collection('users')
        .doc(UserRepository.user!.email)
        .collection('receivedMessages')
        .orderBy('sendAtTime', descending: true)
        .snapshots();

    _receivedMsgSubscription = _receivedMsgStream.listen((snapshot) {
      _receivedMessages = snapshot.docs;
      notifyListeners();
      _updateMessagesCounter();
    });

    _sendedMsgStream = FirebaseFirestore.instance
        .collection('users')
        .doc(UserRepository.user!.email)
        .collection('sendedMessages')
        .orderBy('sendAtTime', descending: true)
        .snapshots();

    _sendedMsgSubscription = _sendedMsgStream.listen((snapshot) {
      _sendedMessages = snapshot.docs;
      notifyListeners();
      _updateMessagesCounter();
    });
  }

  void setFilter(Messages filter) {
    _messageFilter = filter;
    notifyListeners();
  }

  void _updateMessagesCounter() {
    _messagesCounter[Messages.received] = _receivedMessages?.length;
    _messagesCounter[Messages.sended] = _sendedMessages?.length;
    _messagesCounter[Messages.unread] = _countUnreadMessages();
  }

  List<DocumentSnapshot<Map<String, dynamic>>>? get messages {
    switch (_messageFilter) {
      case Messages.received:
        return _receivedMessages;
      case Messages.sended:
        return _sendedMessages;
      case Messages.unread:
        return _receivedMessages
            ?.where((document) => document.get('isUnread') ?? false)
            .toList();
    }
  }

  void cancel() {
    _receivedMsgSubscription.cancel();
    _sendedMsgSubscription.cancel();
    _receivedMessages = null;
    _sendedMessages = null;
  }

  int? _countUnreadMessages() {
    if (_receivedMessages != null) {
      final unreads = _receivedMessages!
          .map((doc) => (doc.data()?['isUnread'] ?? false) as bool);
      final count = unreads.fold(
          0, (previousValue, unread) => previousValue + (unread ? 1 : 0));

      return count;
    }
    return null;
  }

  void deleteAllMessages() async {
    final batch = FirebaseFirestore.instance.batch();

    final messages = await FirebaseFirestore.instance
        .collection('users')
        .doc(UserRepository.user!.email)
        .collection('messages')
        .get();

    for (var document in messages.docs) {
      batch.delete(document.reference);
    }

    await batch.commit();
  }
}
