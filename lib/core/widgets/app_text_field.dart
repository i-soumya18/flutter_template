import 'package:flutter/material.dart';
import 'package:flutter_template/core/theme/app_border_radius.dart';
import 'package:flutter_template/core/theme/app_spacing.dart';

enum AppTextFieldVariant { regular, search, password }

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.error,
    this.prefix,
    this.suffix,
    this.controller,
    this.validator,
    this.keyboardType,
    this.onChanged,
    this.variant = AppTextFieldVariant.regular,
  });

  final String? label;
  final String? hint;
  final String? error;
  final Widget? prefix;
  final Widget? suffix;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final AppTextFieldVariant variant;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> with SingleTickerProviderStateMixin {
  late final ValueNotifier<bool> _obscure;
  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _obscure = ValueNotifier<bool>(widget.variant == AppTextFieldVariant.password);
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 360),
    );
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -8), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8, end: -4), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -4, end: 0), weight: 1),
    ]).animate(_shakeController);
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.error != null && oldWidget.error != widget.error) {
      _shakeController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _obscure.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isSearch = widget.variant == AppTextFieldVariant.search;

    return AnimatedBuilder(
      animation: Listenable.merge([_shakeAnimation, _focusNode]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeAnimation.value, 0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            decoration: BoxDecoration(
              borderRadius: AppBorderRadius.mediumAll,
              border: Border.all(
                color: _focusNode.hasFocus ? colors.primary : colors.outlineVariant,
                width: _focusNode.hasFocus ? 1.5 : 1,
              ),
            ),
            child: child,
          ),
        );
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: _obscure,
        builder: (context, obscure, _) {
          return TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            obscureText: obscure,
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.hint,
              errorText: widget.error,
              prefixIcon: widget.prefix ?? (isSearch ? const Icon(Icons.search) : null),
              suffixIcon: widget.variant == AppTextFieldVariant.password
                  ? IconButton(
                      icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => _obscure.value = !obscure,
                    )
                  : widget.suffix,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
            ),
          );
        },
      ),
    );
  }
}
