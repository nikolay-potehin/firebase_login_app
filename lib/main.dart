import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login_app/localization/localization_delegate.dart';
import 'package:firebase_login_app/theme.dart';
import 'package:firebase_login_app/firebase_options.dart';
import 'package:firebase_login_app/pages/start_page.dart';
import 'package:firebase_login_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      localizationsDelegates: const [
        AppLocalizationDelegate(),
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale.fromSubtags(languageCode: "en"),
        Locale.fromSubtags(languageCode: "ru"),
      ],
      home: const StartPage(),
    );
  }
}
