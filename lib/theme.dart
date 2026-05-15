import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFF1A1333);
  static const Color cardBackground = Color(0xFF2D264C);
  static const Color accentPurple = Color(0xFF8D76E4);
  static const Color textColor = Colors.white;
  static const Color secondaryTextColor = Colors.white70;

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: accentPurple,
      cardColor: cardBackground,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
        bodyMedium: TextStyle(color: textColor, fontSize: 14),
        labelSmall: TextStyle(color: secondaryTextColor, fontSize: 12),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}
