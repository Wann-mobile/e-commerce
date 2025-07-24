import 'package:e_triad/core/extension/context_ext.dart';
import 'package:flutter/material.dart';

abstract class Colours {
  // ==================== BRAND COLORS ====================
  /// Primary brand color - warm pink
  static const Color brandPrimary = Color(0xFFF8DCCE);

  /// Secondary brand color - dusty rose
  static const Color brandSecondary = Color(0xFFB19299);

  /// Brand accent color - soft cream
  static const Color brandAccent = Color(0xFFFFF8F5);

  // ==================== LIGHT MODE COLORS ====================

  // Background Colors
  static const Color lightBackground = Color(0xFFFDF2F8);
  static const Color lightTintBackground = Color(0x47E7DEDE);
  // Color(0xFFFBFAF8);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCardBackground = Color(0xFFFFFFFF);
  static const Color lightHeroBackground = Color(0xFFFFF8F5);

  // Text Colors
  static const Color lightTextPrimary = Color(0xFF1F2937);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color lightTextTertiary = Color(0xFF9CA3AF);

  // Interactive Colors
  static const Color lightButtonPrimary = Color(0xFFF8DCCE);
  static const Color lightButtonHover = Color(0xFFF3D4C4);
  static const Color lightBorder = Color(0xFFE5E7EB);
  static const Color lightInputBackground = Color(0xFFFFFFFF);
  static const Color lightInputBorder = Color(0xFFD1D5DB);

  // Status Colors
  static const Color lightSuccess = Color(0xFF10B981);
  static const Color lightWarning = Color(0xFFF59E0B);
  static const Color lightError = Color(0xFFEF4444);
  static const Color lightInfo = Color(0xFF3B82F6);

  // ==================== DARK MODE COLORS ====================

  // Background Colors
  static const Color darkSeedColor = Color(0xFFDB2777);
  static const Color darkSchemeColor = Color(0xFF02001D);
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkTintBackground = Color(0x542E333D);

  // Color.fromARGB(255, 24, 35, 61);
  static const Color darkBackgroundGradientStart = Color(0xFF1E293B);
  static const Color darkBackgroundGradientEnd = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkCardBackground = Color(0xFF1F1F24);
  static const Color darkHeroBackground = Color(0x99334155);

  // Text Colors
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFD1D5DB);
  static const Color darkTextTertiary = Color(0xFF9CA3AF);
  static const Color darkTextMuted = Color(0xFF6B7280);

  // Interactive Colors
  static const Color darkButtonPrimary = Color(0xCCDB2777);
  static const Color darkButtonSecondary = Color(0xCCF43F5E);
  static const Color darkBottomButton = Color(0xFFDB2777);
  static const Color darkBorder = Color(0x80475569);
  static const Color darkInputBackground = Color(0x80334155);
  static const Color darkInputBorder = Color(0x80475569);

  // Glass Effect Colors
  static const Color darkGlassBackground = Color(0x80334155);
  static const Color darkGlassBackgroundLight = Color(0x4D334155);
  static const Color darkGlassBorder = Color(0x80475569);

  // Accent and Highlight Colors
  static const Color darkAccentPink = Color(0xFFF472B6);
  static const Color darkAccentRose = Color(0xFFFB7185);
  static const Color darkAccentPinkMuted = Color(0x33F472B6);
  static const Color darkAccentRoseMuted = Color(0x33FB7185);

  // Status Colors (Dark Mode)
  static const Color darkSuccess = Color(0xFF34D399);
  static const Color darkWarning = Color(0xFFFBBF24);
  static const Color darkError = Color(0xFFF87171);
  static const Color darkInfo = Color(0xFF60A5FA);

  // ==================== COMMON COLORS ====================

  // Colors that work in both themes
  static const Color transparent = Color(0x00000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Star Rating Color
  static const Color starRating = Color(0xFFFBBF24);

  // Heart/Favorite Colors
  static const Color favoriteActive = Color(0xFFEF4444);
  static const Color favoriteInactive = Color(0xFF9CA3AF);

  // Shadow Colors
  static const Color lightShadow = Color(0x1A000000);
  static const Color darkShadow = Color(0x4D000000);
  static const Color pinkGlow = Color(0xA0DB2777);
  static const Color roseGlow = Color(0x40F43F5E);

  // ==================== GRADIENT DEFINITIONS ====================

  // Light Mode Gradients
  static const LinearGradient lightHeroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFEF2F2), Color(0xFFFFF8F5)],
  );

  static const LinearGradient lightButtonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFF8DCCE), Color(0xFFB19299)],
  );

  // Dark Mode Gradients
  static const LinearGradient darkBackgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E293B), Color(0xFF0F172A), Color(0xFF1F2937)],
  );

  static const LinearGradient darkHeroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x99334155), Color(0xCC1E293B)],
  );

  static const LinearGradient darkButtonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xCCDB2777), Color(0xCCF43F5E)],
  );

  static const LinearGradient darkButtonHoverGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFDB2777), Color(0xFFF43F5E)],
  );

  // Ambient Background Effects for Dark Mode
  static const RadialGradient darkAmbientPink = RadialGradient(
    center: Alignment.topLeft,
    radius: 1.5,
    colors: [Color(0x0DDB2777), Color(0x00000000)],
  );

  static const RadialGradient darkAmbientRose = RadialGradient(
    center: Alignment.bottomRight,
    radius: 1.5,
    colors: [Color(0x0DF43F5E), Color(0x00000000)],
  );

  // ==================== UTILITY METHODS ====================

  static Color classicAdaptiveTextColor(BuildContext context) =>
      context.adaptiveColor(
        lightColor: Colours.lightTextPrimary,
        darkColor: Colours.darkTextPrimary,
      );

  static Color classicAdaptiveSecondaryTextColor(BuildContext context) =>
      context.adaptiveColor(
        lightColor: Colours.lightTextSecondary,
        darkColor: Colours.darkTextSecondary,
      );

  static Color classicAdaptiveBackgroundColor(BuildContext context) =>
      context.adaptiveColor(
        lightColor: Colours.lightBackground,
        darkColor: Colours.darkBackground,
      );

  static Color classicAdaptiveSurfaceColor(BuildContext context) =>
      context.adaptiveColor(
        lightColor: Colours.darkSurface,
        darkColor: Colours.lightSurface,
      );

  static Color classicAdaptiveButtonOrIconColor(BuildContext context) =>
      context.adaptiveColor(
        lightColor: Colours.darkBottomButton,
        darkColor: Colours.darkButtonSecondary,
      );

  static Color classicAdaptive(BuildContext context) =>
      context.adaptiveColor(
        lightColor: Colours.lightBorder,
        darkColor: Colours.darkBorder,
      );
  static Color classicAdaptiveBgCardColor(BuildContext context) =>
      context.adaptiveColor(
        lightColor: Colours.lightCardBackground,
        darkColor: Colours.darkCardBackground,
      );
}
