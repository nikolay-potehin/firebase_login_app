import 'package:firebase_login_app/models/material_color_generator.dart';
import 'package:flutter/material.dart';

final myPrimarySwatch = MaterialColorGenerator.from(
  const Color.fromARGB(255, 0, 180, 120),
);

const myInputDecorationTheme = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
  fillColor: Colors.white,
  filled: true,
);

final myFilledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
  foregroundColor: Colors.white,
  minimumSize: const Size.fromHeight(50),
  textStyle: const TextStyle(
    fontSize: 16,
    letterSpacing: 1,
    fontWeight: FontWeight.w500,
  ),
));

final myTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
  textStyle: const TextStyle(fontWeight: FontWeight.w500),
));

final myElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  textStyle: const TextStyle(fontWeight: FontWeight.w500),
));

const myAppBarTheme = AppBarTheme(
  foregroundColor: Colors.white,
  centerTitle: true,
);

const mySnackBarTheme = SnackBarThemeData(
  contentTextStyle: TextStyle(fontSize: 16, letterSpacing: 0.25),
  behavior: SnackBarBehavior.floating,
);

final myThemeData = ThemeData(
  primarySwatch: myPrimarySwatch,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: myAppBarTheme,
  inputDecorationTheme: myInputDecorationTheme,
  filledButtonTheme: myFilledButtonTheme,
  elevatedButtonTheme: myElevatedButtonTheme,
  textButtonTheme: myTextButtonTheme,
  snackBarTheme: mySnackBarTheme,
);
