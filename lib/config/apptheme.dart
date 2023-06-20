import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static ThemeData get theme => ThemeData(
        appBarTheme:
            const AppBarTheme(elevation: 0, backgroundColor: Colors.transparent, centerTitle: true),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                backgroundColor: Colors.black)),
        scaffoldBackgroundColor: Colors.grey[300],
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      );
}
