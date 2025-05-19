import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class ThemeLight {
  static Color highlight = const Color(0xFF053225);
  static Color secondary = const Color(0xFFFFFFFF);
  static Color dominant = const Color(0xFFF1F1F1);
  static Color error = const Color(0xFF9C1616);
  static Color input = Colors.grey.withOpacity(0.2);
  static ThemeData themeData = ThemeData(
    primaryColor: highlight,
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: highlight,
          secondary: secondary,
        ),
    appBarTheme: AppBarTheme(backgroundColor: dominant),
    scaffoldBackgroundColor: dominant,
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(8),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: error),
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: highlight),
            borderRadius: BorderRadius.circular(8)),
        border: OutlineInputBorder(
            borderSide: const BorderSide(style: BorderStyle.none, width: 0),
            borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: input),
    textTheme: GoogleFonts.openSansTextTheme(),
    buttonTheme: const ButtonThemeData(),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: highlight,
            disabledMouseCursor: SystemMouseCursors.forbidden,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)))),
  );
}
