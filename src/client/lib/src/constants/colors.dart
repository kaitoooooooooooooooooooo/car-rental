import 'package:flutter/material.dart';

/// Palette "Dark Luxury" : noir olive + gris olive + blanc cassé + vert citron.
class AppColors {
  AppColors._();

  // Base
  static const Color primary = Color(0xFF11110F);
  static const Color secondary = Color(0xFF34362F);
  static const Color accent = Color(0xFFE5F586);
  static const Color accentHover = Color(0xFFD7E878);
  static const Color accentSoft = Color(0x33E5F586);
  static const Color onAccent = Color(0xFF11110F);

  // Surfaces
  static const Color background = Color(0xFF11110F);
  static const Color surfaceLow = Color(0xFF1B1C18);
  static const Color surface = Color(0xFF30322B);
  static const Color surfaceElevated = Color(0xFF3A3C34);

  // Dégradé carte voiture (noir en haut → jaune en bas)
  static const Color gradientDark = Color(0xFF292929);
  static const Color gradientYellow = Color(0xFFEFFE7D);

  // Texte
  static const Color textPrimary = Color(0xFFF4F4F0);
  static const Color textSecondary = Color(0xFFA7A99F);
  static const Color textMuted = Color(0xFF777970);

  // Bordures
  static const Color stoke = Color(0xFF4A4C44);
  static const Color borderSubtle = Color(0xFF363830);

  // États
  static const Color success = Color(0xFFE5F586);
  static const Color warning = Color(0xFFD9C86C);
  static const Color error = Color(0xFFD96868);

  // Alias conservés pour compatibilité
  static const Color terseri = accent;
  static const Color white = textPrimary;
  static const Color buttons = textPrimary;
  static const Color icon = textSecondary;
}
