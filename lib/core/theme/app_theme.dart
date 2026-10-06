import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Main theme for the With Me app.
///
/// Design:
/// - Midnight Blue background
/// - Soft Lavender primary color
/// - Indigo surfaces
/// - Warm light text
class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // -----------------------------------------------------------------------
      // COLORS
      // -----------------------------------------------------------------------

      scaffoldBackgroundColor: AppColors.background,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: AppColors.background,
        secondary: AppColors.primaryLight,
        onSecondary: AppColors.background,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        error: AppColors.error,
        onError: AppColors.textPrimary,
      ),

      // -----------------------------------------------------------------------
      // APP BAR
      // -----------------------------------------------------------------------

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
      ),

      // -----------------------------------------------------------------------
      // TEXT
      // -----------------------------------------------------------------------

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textSecondary,
        ),
        bodySmall: TextStyle(
          color: AppColors.textMuted,
        ),
        labelLarge: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: TextStyle(
          color: AppColors.textSecondary,
        ),
        labelSmall: TextStyle(
          color: AppColors.textMuted,
        ),
      ),

      // -----------------------------------------------------------------------
      // TEXT FIELDS
      // -----------------------------------------------------------------------

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,

        hintStyle: const TextStyle(
          color: AppColors.textMuted,
        ),

        labelStyle: const TextStyle(
          color: AppColors.textSecondary,
        ),

        prefixIconColor: AppColors.textSecondary,
        suffixIconColor: AppColors.textSecondary,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.indigoSlate,
            width: 1,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),
      ),

      // -----------------------------------------------------------------------
      // ELEVATED BUTTON
      // -----------------------------------------------------------------------

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.background,

          disabledBackgroundColor:
              AppColors.primary.withValues(alpha: 0.5),

          disabledForegroundColor:
              AppColors.background.withValues(alpha: 0.6),

          elevation: 3,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),

          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // -----------------------------------------------------------------------
      // OUTLINED BUTTON
      // -----------------------------------------------------------------------

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,

          side: const BorderSide(
            color: AppColors.primary,
            width: 1,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
        ),
      ),

      // -----------------------------------------------------------------------
      // TEXT BUTTON
      // -----------------------------------------------------------------------

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
        ),
      ),

      // -----------------------------------------------------------------------
      // CHECKBOX
      // -----------------------------------------------------------------------

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }

          return AppColors.surfaceLight;
        }),

        checkColor: WidgetStateProperty.all(
          AppColors.background,
        ),

        side: const BorderSide(
          color: AppColors.indigoSlate,
          width: 1.5,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),

      // -----------------------------------------------------------------------
      // DIVIDER
      // -----------------------------------------------------------------------

      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // -----------------------------------------------------------------------
      // CARD
      // -----------------------------------------------------------------------

      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 2,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),

        margin: EdgeInsets.zero,
      ),

      // -----------------------------------------------------------------------
      // DIALOG
      // -----------------------------------------------------------------------

      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),

        titleTextStyle: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),

        contentTextStyle: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 15,
        ),
      ),

      // -----------------------------------------------------------------------
      // SNACKBAR
      // -----------------------------------------------------------------------

      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceLight,

        contentTextStyle: const TextStyle(
          color: AppColors.textPrimary,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),

        behavior: SnackBarBehavior.floating,
      ),

      // -----------------------------------------------------------------------
      // PROGRESS INDICATOR
      // -----------------------------------------------------------------------

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),

      // -----------------------------------------------------------------------
      // ICONS
      // -----------------------------------------------------------------------

      iconTheme: const IconThemeData(
        color: AppColors.textSecondary,
      ),

      // -----------------------------------------------------------------------
      // SWITCH
      // -----------------------------------------------------------------------

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }

          return AppColors.textMuted;
        }),

        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary.withValues(alpha: 0.35);
          }

          return AppColors.surfaceLight;
        }),
      ),
    );
  }
}