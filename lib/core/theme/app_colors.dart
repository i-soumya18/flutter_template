import 'package:flutter/material.dart';

class AppColorTokens {
  const AppColorTokens({
    required this.primary,
    required this.primaryDark,
    required this.secondary,
    required this.surface,
    required this.surfaceVariant,
    required this.background,
    required this.onPrimary,
    required this.onSurface,
    required this.onBackground,
    required this.border,
    required this.divider,
    required this.success,
    required this.warning,
    required this.error,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.shimmerBase,
    required this.shimmerHighlight,
  });

  final Color primary;
  final Color primaryDark;
  final Color secondary;
  final Color surface;
  final Color surfaceVariant;
  final Color background;
  final Color onPrimary;
  final Color onSurface;
  final Color onBackground;
  final Color border;
  final Color divider;
  final Color success;
  final Color warning;
  final Color error;
  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;
  final Color shimmerBase;
  final Color shimmerHighlight;
}

class AppColors {
  const AppColors._();

  static const light = AppColorTokens(
    primary: Color(0xFF2563EB),
    primaryDark: Color(0xFF1D4ED8),
    secondary: Color(0xFF06B6D4),
    surface: Color(0xFFFFFFFF),
    surfaceVariant: Color(0xFFF1F5F9),
    background: Color(0xFFF8FAFC),
    onPrimary: Color(0xFFFFFFFF),
    onSurface: Color(0xFF0F172A),
    onBackground: Color(0xFF0F172A),
    border: Color(0xFFE2E8F0),
    divider: Color(0xFFCBD5E1),
    success: Color(0xFF16A34A),
    warning: Color(0xFFF59E0B),
    error: Color(0xFFDC2626),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF475569),
    textDisabled: Color(0xFF94A3B8),
    shimmerBase: Color(0xFFE2E8F0),
    shimmerHighlight: Color(0xFFF8FAFC),
  );

  static const dark = AppColorTokens(
    primary: Color(0xFF60A5FA),
    primaryDark: Color(0xFF3B82F6),
    secondary: Color(0xFF22D3EE),
    surface: Color(0xFF0B1220),
    surfaceVariant: Color(0xFF111827),
    background: Color(0xFF020617),
    onPrimary: Color(0xFF020617),
    onSurface: Color(0xFFF8FAFC),
    onBackground: Color(0xFFF8FAFC),
    border: Color(0xFF1E293B),
    divider: Color(0xFF334155),
    success: Color(0xFF22C55E),
    warning: Color(0xFFFBBF24),
    error: Color(0xFFF87171),
    textPrimary: Color(0xFFF8FAFC),
    textSecondary: Color(0xFFCBD5E1),
    textDisabled: Color(0xFF64748B),
    shimmerBase: Color(0xFF1E293B),
    shimmerHighlight: Color(0xFF334155),
  );
}
