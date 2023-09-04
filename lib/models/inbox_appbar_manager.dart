import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/repositories/messaging_repository.dart';
import 'package:flutter/material.dart';

class InboxAppbarManager extends ChangeNotifier {
  final _selectedMessages = <DocumentSnapshot<Map<String, dynamic>>>[];

  bool get isActive => _selectedMessages.isNotEmpty;
  int get countSelected => _selectedMessages.length;

  InboxAppbarManager();

  bool isSelected({required DocumentSnapshot<Map<String, dynamic>> message}) {
    return _selectedMessages.contains(message);
  }

  void toggle({required DocumentSnapshot<Map<String, dynamic>> message}) {
    if (isSelected(message: message)) {
      _unselectMessage(message);
    } else {
      _selectMessage(message);
    }
  }

  void _selectMessage(DocumentSnapshot<Map<String, dynamic>> message) {
    _selectedMessages.add(message);
    notifyListeners();
  }

  void _unselectMessage(DocumentSnapshot<Map<String, dynamic>> message) {
    _selectedMessages.remove(message);
    notifyListeners();
  }

  void unselectAll() {
    _selectedMessages.clear();
    notifyListeners();
  }

  Future<void> deleteSelectedMessages() {
    return MessagingRepository.deleteMessages(_selectedMessages)
        .then((value) => unselectAll());
  }
}
