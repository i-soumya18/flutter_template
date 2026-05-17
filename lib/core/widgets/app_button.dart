import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/core/theme/app_border_radius.dart';
import 'package:flutter_template/core/theme/app_spacing.dart';

enum AppButtonVariant { primary, secondary, ghost, destructive }

class AppButton extends StatefulWidget {
  const AppButton({
    required this.onPressed,
    required this.label,
    super.key,
    this.icon,
    this.loading = false,
    this.disabled = false,
    this.width,
    this.variant = AppButtonVariant.primary,
  });

  final VoidCallback? onPressed;
  final String label;
  final Widget? icon;
  final bool loading;
  final bool disabled;
  final double? width;
  final AppButtonVariant variant;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  final ValueNotifier<bool> _pressed = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _pressed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.disabled || widget.loading || widget.onPressed == null;
    final style = _style(context, widget.variant, isDisabled);

    return ValueListenableBuilder<bool>(
      valueListenable: _pressed,
      builder: (_, pressed, child) {
        return AnimatedScale(
          duration: const Duration(milliseconds: 120),
          scale: pressed ? 0.97 : 1,
          child: Listener(
            onPointerDown: (_) => _pressed.value = true,
            onPointerUp: (_) => _pressed.value = false,
            onPointerCancel: (_) => _pressed.value = false,
            child: SizedBox(
              width: widget.width ?? double.infinity,
              child: ElevatedButton(
                style: style,
                onPressed: isDisabled
                    ? null
                    : () async {
                        await HapticFeedback.lightImpact();
                        widget.onPressed?.call();
                      },
                child: child,
              ),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.loading)
              const SizedBox.square(
                dimension: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else if (widget.icon != null) ...[
              widget.icon!,
              const SizedBox(width: AppSpacing.sm),
            ],
            Text(widget.label),
          ],
        ),
      ),
    );
  }

  ButtonStyle _style(BuildContext context, AppButtonVariant variant, bool disabled) {
    final colors = Theme.of(context).colorScheme;
    final base = ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: AppBorderRadius.mediumAll,
      ),
      minimumSize: const Size(0, 52),
      elevation: 0,
    );
    return base.copyWith(
      backgroundColor: WidgetStatePropertyAll(
        switch (variant) {
          AppButtonVariant.primary => colors.primary,
          AppButtonVariant.secondary => colors.secondaryContainer,
          AppButtonVariant.ghost => Colors.transparent,
          AppButtonVariant.destructive => colors.error,
        },
      ),
      foregroundColor: WidgetStatePropertyAll(
        switch (variant) {
          AppButtonVariant.primary => colors.onPrimary,
          AppButtonVariant.secondary => colors.onSecondaryContainer,
          AppButtonVariant.ghost => colors.primary,
          AppButtonVariant.destructive => colors.onError,
        },
      ),
      side: WidgetStatePropertyAll(
        variant == AppButtonVariant.ghost
            ? BorderSide(color: colors.outlineVariant)
            : BorderSide.none,
      ),
      overlayColor: WidgetStatePropertyAll(colors.onSurface.withValues(alpha: 0.08)),
    );
  }
}
