import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login_app/theme.dart';
import 'package:firebase_login_app/firebase_options.dart';
import 'package:firebase_login_app/pages/start_page.dart';
import 'package:firebase_login_app/models/utils.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Box',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: Utils.messengerKey,
      theme: myThemeData,
      home: const StartPage(),
    );
  }
}
