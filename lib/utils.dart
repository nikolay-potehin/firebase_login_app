import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:flutter/material.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static void showMessage(LocKeys errorLocKey) {
    final String? msg = messengerKey.currentContext?.localize(errorLocKey);

    if (msg != null) showSnackBar(msg);
  }

  static void showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));

    messengerKey.currentState
      ?..clearSnackBars()
      ..showSnackBar(snackBar);
  }

  static Future<bool?> showWarning(
    BuildContext context, {
    required String title,
    String? content,
    bool barrierDismissible = true,
  }) async =>
      showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: content == null ? null : Text(content),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(context.localize(LocKeys.no)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(context.localize(LocKeys.yes)),
            ),
          ],
        ),
      );

  static Future<T> showLoading<T>(
    BuildContext dialogContext,
    Future<T> future,
  ) async {
    showDialog(
      context: dialogContext,
      barrierDismissible: false,
      builder: (context) {
        dialogContext = context;
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    await future;
    if (dialogContext.mounted) Navigator.of(dialogContext).pop();
    return future;
  }
}
