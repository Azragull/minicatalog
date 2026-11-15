import 'package:flutter/material.dart';

/// App theme: black background with burgundy / red accents
class AppTheme {
  static const Color burgundy = Color(0xFF7A0F1F); // app bar, buttons
  static const Color primary = Color(0xFFD6334A); // prices, highlights
  static const Color background = Color(0xFF0D0D0D);
  static const Color surface = Color(0xFF181818);
  static const Color border = Color(0xFF2C2C2C);
  static const Color textMuted = Color(0xFFA6A6A6);

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: burgundy,
        brightness: Brightness.dark,
        primary: primary,
        surface: surface,
      ),
      scaffoldBackgroundColor: background,
      // Transparent app bar that blends into the black background,
      // separated from the content by a thin burgundy line
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        shape: Border(bottom: BorderSide(color: burgundy, width: 1)),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
          color: Colors.white,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(color: border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        hintStyle: const TextStyle(color: textMuted),
        prefixIconColor: textMuted,
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: primary),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: burgundy,
          foregroundColor: Colors.white,
          disabledBackgroundColor: border,
          disabledForegroundColor: textMuted,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: burgundy,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      badgeTheme: const BadgeThemeData(backgroundColor: Colors.white, textColor: burgundy),
      dividerTheme: const DividerThemeData(color: border, space: 1),
    );
  }
}
