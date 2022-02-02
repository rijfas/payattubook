import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const lightPrimaryColor = Color(0xFF26354B);
  static const lightSecondaryColor = Color(0xFFA8AEB6);
  static const lightInputBackgroundColor = Color(0xFFF5F7F9);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: lightPrimaryColor),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: lightPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0.0,
      backgroundColor: Colors.white,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      selectedItemColor: lightPrimaryColor,
      unselectedItemColor: lightSecondaryColor,
    ),
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(
      color: lightPrimaryColor,
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: lightPrimaryColor),
      bodyText2: TextStyle(color: lightPrimaryColor),
      subtitle1: TextStyle(color: lightPrimaryColor),
    ),
    primaryColor: lightPrimaryColor,
    colorScheme: const ColorScheme.light()
        .copyWith(primary: lightPrimaryColor, secondary: lightSecondaryColor),
  );
}
