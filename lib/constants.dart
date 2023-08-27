import 'package:firebase_login_app/models/material_color_generator.dart';
import 'package:flutter/material.dart';

final myPrimarySwatch = MaterialColorGenerator.from(
  const Color.fromARGB(255, 0, 180, 120),
);

const myInputDecorationTheme = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
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

const myAppBarTheme = AppBarTheme(
  foregroundColor: Colors.white,
  centerTitle: true,
);

ThemeData myThemeData() => ThemeData(
      primarySwatch: myPrimarySwatch,
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: myInputDecorationTheme,
      filledButtonTheme: myFilledButtonTheme,
      textButtonTheme: myTextButtonTheme,
      appBarTheme: myAppBarTheme,
    );
