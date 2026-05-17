import 'package:flutter/material.dart';
import 'package:flutter_template/core/widgets/app_button.dart';

class AppErrorView extends StatelessWidget {
  const AppErrorView({
    required this.message,
    super.key,
    this.onRetry,
    this.icon,
    this.fullScreen = false,
  });

  final String message;
  final VoidCallback? onRetry;
  final IconData? icon;
  final bool fullScreen;

  @override
  Widget build(BuildContext context) {
    final child = Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon ?? Icons.error_outline, size: 42),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              AppButton(
                onPressed: onRetry,
                label: 'Retry',
                width: 160,
              ),
            ],
          ],
        ),
      ),
    );
    return fullScreen ? Scaffold(body: child) : child;
  }
}
