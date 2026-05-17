import 'package:flutter/material.dart';
import 'package:flutter_template/core/theme/app_colors.dart';

class AppTextStyles {
  const AppTextStyles._();

  static const _display = 'ClashDisplay';
  static const _body = 'DMSans';
  static const _mono = 'JetBrainsMono';

  static TextTheme build(AppColorTokens colors) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: _display,
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
      ),
      displayMedium: TextStyle(
        fontFamily: _display,
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
      ),
      displaySmall: TextStyle(
        fontFamily: _display,
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),
      headlineLarge: TextStyle(
        fontFamily: _display,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontFamily: _display,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),
      headlineSmall: TextStyle(
        fontFamily: _display,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),
      titleLarge: TextStyle(
        fontFamily: _body,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontFamily: _body,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),
      titleSmall: TextStyle(
        fontFamily: _body,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontFamily: _body,
        fontSize: 16,
        color: colors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontFamily: _body,
        fontSize: 14,
        color: colors.textPrimary,
      ),
      bodySmall: TextStyle(
        fontFamily: _body,
        fontSize: 12,
        color: colors.textSecondary,
      ),
      labelLarge: TextStyle(
        fontFamily: _body,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colors.textPrimary,
      ),
      labelMedium: TextStyle(
        fontFamily: _body,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: colors.textPrimary,
      ),
      labelSmall: TextStyle(
        fontFamily: _body,
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: colors.textSecondary,
      ),
    );
  }

  static TextStyle codeLarge(AppColorTokens colors) => TextStyle(
        fontFamily: _mono,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: colors.textPrimary,
      );

  static TextStyle codeSmall(AppColorTokens colors) => TextStyle(
        fontFamily: _mono,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: colors.textSecondary,
      );
}
