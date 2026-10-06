import 'package:flutter/material.dart';

/// Official color palette for the With Me app.
///
/// Theme:
/// - Midnight Blue
/// - Soft Lavender
/// - Subtle Indigo
/// - Warm light text
class AppColors {
  // ===========================================================================
  // BACKGROUND
  // ===========================================================================

  /// Main app background.
  static const Color background = Color(0xFF0B1020);

  /// Gradient middle tone.
  static const Color gradientMid = Color(0xFF151B32);

  // ===========================================================================
  // SURFACES
  // ===========================================================================

  /// Main cards and elevated surfaces.
  static const Color surface = Color(0xFF151B32);

  /// Lighter card / input surface.
  static const Color surfaceLight = Color(0xFF232A46);

  /// Indigo slate used for subtle borders and background effects.
  static const Color indigoSlate = Color(0xFF2A3150);

  // ===========================================================================
  // PRIMARY — SOFT LAVENDER
  // ===========================================================================

  /// Main brand accent.
  static const Color primary = Color(0xFFA78BFA);

  /// Lighter version of the primary lavender.
  static const Color primaryLight = Color(0xFFC4B5FD);

  // ===========================================================================
  // APP ACCENT
  // ===========================================================================

  /// Main accent used throughout the existing app UI.
  ///
  /// Kept under the old name so existing screens automatically
  /// switch from red to the new lavender palette.
  static const Color accentRed = Color(0xFFA78BFA);

  /// Additional pink/purple shades available for future UI elements.
  static const Color neonPink = Color(0xFFF72585);
  static const Color hotPinkMagenta = Color(0xFFE01A88);
  static const Color pinkishPurple = Color(0xFFD946EF);
  static const Color neonMagenta = Color(0xFFC026D3);
  static const Color electricViolet = Color(0xFF7C3AED);
  static const Color electricPurple = Color(0xFF9B59B6);

  // ===========================================================================
  // TEXT
  // ===========================================================================

  /// Main warm white text.
  static const Color textPrimary = Color(0xFFF5F1E8);

  /// Secondary text.
  static const Color textSecondary = Color(0xFFB8BECC);

  /// Muted / disabled text.
  static const Color textMuted = Color(0xFF768087);

  /// Small warm highlight.
  static const Color highlightGold = Color(0xFFD6B56D);

  // ===========================================================================
  // SYSTEM
  // ===========================================================================

  static const Color divider = Color(0xFF242D4A);

  /// Soft error red — only for actual errors.
  static const Color error = Color(0xFFE57373);

  static const Color success = Color(0xFF81C784);
}