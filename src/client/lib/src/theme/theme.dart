import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color accent = Color(0xFF7B1B38);
  static final Color accentLight = Color.fromARGB(172, 252, 251, 252);
  static final Color accentSoft = accent.withValues(alpha: 0.2);
  static const Color onAccent = textPrimary;

  static const Color background = Color(0xFF121212);
  static const Color surfaceLow = Color(0xFF1A1A1A);
  static const Color surface = Color(0xFF242424);

  static const Color textPrimary = Color(0xFFF4F4F4);
  static const Color textSecondary = Color(0xFFB8B8B8);
  static const Color textMuted = Color(0xFF828282);

  static const Color stoke = Color(0xFF444444);
  static const Color borderSubtle = Color(0xFF2E2E2E);

  static const Color error = Color(0xFFD96868);
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
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.accentLight,
    selectionColor: AppColors.accentSoft,
    selectionHandleColor: AppColors.accentLight,
  ),
);
