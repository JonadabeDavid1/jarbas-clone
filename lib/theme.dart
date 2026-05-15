import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFF1A1333);
  static const Color cardBackground = Color(0xFF2D264C);
  static const Color accentPurple = Color(0xFF8D76E4);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accentPurple,
        brightness: Brightness.dark,
        surface: background,
        onSurface: Colors.white,
        primary: accentPurple,
      ),
      scaffoldBackgroundColor: background,
      // Usando cardColor diretamente para evitar conflitos de versão do CardTheme
      cardColor: cardBackground,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}
