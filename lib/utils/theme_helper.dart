import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeHelper {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xfffef6ff),
      brightness: Brightness.dark,
      primaryColor: const Color(0xff5927e5),
      textTheme: GoogleFonts.latoTextTheme(const TextTheme(
        headlineLarge: TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
        labelLarge: TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(
          fontSize: 36,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
            fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
      )),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.black),
      snackBarTheme: const SnackBarThemeData(
          contentTextStyle: TextStyle(color: Colors.white)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              primary: const Color(0xff5927e5))),
      cardTheme: const CardTheme(
        margin: EdgeInsets.zero,
        color: Color(0xff362b48),
      ),
      appBarTheme: const AppBarTheme(
          color: Color(0xff5927e5),
          titleTextStyle: TextStyle(fontSize: 18),
          centerTitle: true));

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xfffef6ff),
      brightness: Brightness.dark,
      primaryColor: const Color(0xff5927e5),
      textTheme: GoogleFonts.latoTextTheme(const TextTheme(
        headlineLarge: TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
        labelLarge: TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(
          fontSize: 36,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
            fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
      )),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.black),
      snackBarTheme: const SnackBarThemeData(
          contentTextStyle: TextStyle(color: Colors.white)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              primary: const Color(0xff5927e5))),
      cardTheme: const CardTheme(
        margin: EdgeInsets.zero,
        color: Color(0xff362b48),
      ),
      appBarTheme: const AppBarTheme(
          color: Color(0xff5927e5),
          titleTextStyle: TextStyle(fontSize: 18),
          centerTitle: true));
}
