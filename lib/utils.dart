import 'package:flutter/material.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static void showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));

    messengerKey.currentState
      ?..clearSnackBars()
      ..showSnackBar(snackBar);
  }
}
