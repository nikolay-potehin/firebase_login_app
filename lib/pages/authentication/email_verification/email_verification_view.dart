import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:firebase_login_app/pages/authentication/authentication_page.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:firebase_login_app/utils.dart';
import 'package:flutter/material.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({
    super.key,
  });

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.localize(LocKeys.emailVerification))),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${context.localize(LocKeys.aVerificationEmailHasBeenSentToYourEmail)}'
              ' "${UserRepository.user?.email}"',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () async {
                final shouldLogout = await Utils.showWarning(
                      context,
                      title: context.localize(LocKeys.cancelRegistration),
                      content:
                          context.localize(LocKeys.cancelRegistrationWarning),
                      barrierDismissible: false,
                    ) ??
                    false;

                if (shouldLogout) deleteUser();
              },
              child: Text(context.localize(LocKeys.cancel).toUpperCase()),
            ),
          ],
        ),
      ),
    );
  }

  void deleteUser() {
    UserRepository.delete();
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => const AuthenticationPage(),
    ));
  }
}
