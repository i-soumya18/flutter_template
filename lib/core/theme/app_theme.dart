import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/theme/app_border_radius.dart';
import 'package:flutter_template/core/theme/app_colors.dart';
import 'package:flutter_template/core/theme/app_text_styles.dart';

final themeModeProvider = StateProvider<ThemeMode>((_) => ThemeMode.system);

class AppTheme {
  const AppTheme._();

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final colors = brightness == Brightness.dark ? AppColors.dark : AppColors.light;
    final scheme = ColorScheme.fromSeed(
      seedColor: colors.primary,
      brightness: brightness,
      primary: colors.primary,
      secondary: colors.secondary,
      surface: colors.surface,
      error: colors.error,
      onPrimary: colors.onPrimary,
      onSurface: colors.onSurface,
      onError: colors.onPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: colors.background,
      textTheme: AppTextStyles.build(colors),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.mediumAll),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.mediumAll),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.textPrimary,
          side: BorderSide(color: colors.border),
          shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.mediumAll),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.primary,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: AppBorderRadius.mediumAll,
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.mediumAll,
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.mediumAll,
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.textSecondary,
        backgroundColor: colors.surface,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.surface,
        indicatorColor: colors.primary.withValues(alpha: 0.14),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surface,
        shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.largeAll),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colors.surfaceVariant,
        contentTextStyle: TextStyle(color: colors.textPrimary),
      ),
    );
  }
}
