import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color accent = Color(0xFF408b77);
  static const Color accentSoft = Color(0x33408B77);
  static const Color onAccent = Color(0xFFF2F4F3);

  static const Color background = Color(0xFF444946);
  static const Color surfaceLow = Color(0xFF1B1D1C);
  static const Color surface = Color(0xFF2C302E);

  static const Color textPrimary = Color(0xFFF2F4F3);
  static const Color textSecondary = Color(0xFFB4BAB6);
  static const Color textMuted = Color(0xFF7D8480);

  static const Color stoke = Color(0xFF5A605C);
  static const Color borderSubtle = Color(0xFF3A3F3C);

  static const Color error = Color(0xFFD96868);

  static const Color gradientDark = Color(0xFF292929);
  static const Color gradientGreen = Color(0xFF2e685a);
}

ThemeData primaryTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: GoogleFonts.manropeTextTheme(ThemeData.dark().textTheme),
  scaffoldBackgroundColor: AppColors.background,
  canvasColor: AppColors.surfaceLow,
  dividerColor: AppColors.borderSubtle,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.accent,
    onPrimary: AppColors.onAccent,
    secondary: AppColors.accent,
    onSecondary: AppColors.onAccent,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    onSurfaceVariant: AppColors.textSecondary,
    surfaceContainerLow: AppColors.surfaceLow,
    outline: AppColors.stoke,
    outlineVariant: AppColors.borderSubtle,
    error: AppColors.error,
    onError: AppColors.onAccent,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.accent,
    selectionColor: AppColors.accentSoft,
    selectionHandleColor: AppColors.accent,
  ),
);
