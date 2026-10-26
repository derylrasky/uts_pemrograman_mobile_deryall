import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // PostHog Design System Colors from DESIGN (4).md
  static const Color primaryYellow = Color(0xFFF7A501);
  static const Color primaryPressed = Color(0xFFDD9001);
  static const Color onPrimary = Color(0xFF23251D);
  static const Color canvasCream = Color(0xFFEEEFE9);
  static const Color surfaceCard = Color(0xFFFFFFFF);
  static const Color inkCharcoal = Color(0xFF23251D);
  static const Color bodyOlive = Color(0xFF4D4F46);
  static const Color hairline = Color(0xFFBFC1B7);
  static const Color surfaceSoft = Color(0xFFE5E7E0);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primaryYellow,
        onPrimary: onPrimary,
        primaryContainer: primaryYellow,
        onPrimaryContainer: onPrimary,
        secondary: primaryPressed,
        onSecondary: onPrimary,
        surface: surfaceCard,
        onSurface: inkCharcoal,
        onSurfaceVariant: bodyOlive,
        outline: hairline,
        outlineVariant: hairline,
        error: const Color(0xFFCD4239),
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: canvasCream,
      cardColor: surfaceCard,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceCard,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        prefixIconColor: bodyOlive,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: hairline, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: hairline, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: primaryYellow, width: 2),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: primaryYellow,
        onPrimary: onPrimary,
        primaryContainer: primaryYellow,
        onPrimaryContainer: onPrimary,
        secondary: primaryPressed,
        onSecondary: onPrimary,
        surface: const Color(0xFF23251D),
        onSurface: const Color(0xFFFFFFFF),
        onSurfaceVariant: const Color(0xFF9B9C92),
        outline: const Color(0xFF4D4F46),
        outlineVariant: const Color(0xFF4D4F46),
        error: const Color(0xFFCD4239),
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFF181914),
      cardColor: const Color(0xFF23251D),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2E3028),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        prefixIconColor: const Color(0xFF9B9C92),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: Color(0xFF4D4F46), width: 1),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: Color(0xFF4D4F46), width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: primaryYellow, width: 2),
        ),
      ),
    );
  }
}
