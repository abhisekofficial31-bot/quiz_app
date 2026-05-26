import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Single static theme — no provider, no switching
class AppTheme {
  AppTheme._();

  static const Color primary    = Color(0xFFFF6B35);
  static const Color secondary  = Color(0xFF1A1A2E);
  static const Color accent     = Color(0xFFFFD700);
  static const Color background = Color(0xFFFAF8F5);
  static const Color cardBg     = Colors.white;
  static const Color textDark   = Color(0xFF1A1A2E);
  static const Color textLight  = Color(0xFF8A8A9A);
  static const Color success    = Color(0xFF4CAF50);
  static const Color error      = Color(0xFFE53935);
  static const Color extra1     = Color(0xFF7C4DFF);
  static const Color extra2     = Color(0xFF00BCD4);
  static const Color purple     = Color(0xFF7C4DFF);
  static const Color teal       = Color(0xFF00BCD4);
  static const Color pink       = Color(0xFFE91E8C);
  static const bool  isDark     = false;

  static const List<Color> categoryColors = [
    Color(0xFFFF6B35), Color(0xFF7C4DFF), Color(0xFF00BCD4),
    Color(0xFFE91E8C), Color(0xFF4CAF50), Color(0xFFFF9800),
    Color(0xFF2196F3), Color(0xFF9C27B0), Color(0xFFE53935),
    Color(0xFF009688),
  ];

  static Color categoryColor(int index) =>
      categoryColors[index % categoryColors.length];

  static ThemeData get flutterTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: textDark,
      displayColor: textDark,
    ),
    scaffoldBackgroundColor: background,
    appBarTheme: AppBarTheme(
      backgroundColor: background,
      foregroundColor: textDark,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: textDark),
  );
}
