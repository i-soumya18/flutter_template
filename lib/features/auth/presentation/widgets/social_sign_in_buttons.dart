import 'package:flutter/material.dart';
import 'package:flutter_template/core/widgets/app_button.dart';

class SocialSignInButtons extends StatelessWidget {
  const SocialSignInButtons({
    super.key,
    this.onGoogle,
    this.onApple,
  });

  final VoidCallback? onGoogle;
  final VoidCallback? onApple;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton(
          onPressed: onGoogle,
          label: 'Continue with Google',
          icon: const Icon(Icons.g_mobiledata),
          variant: AppButtonVariant.secondary,
        ),
        const SizedBox(height: 12),
        AppButton(
          onPressed: onApple,
          label: 'Continue with Apple',
          icon: const Icon(Icons.apple),
          variant: AppButtonVariant.ghost,
        ),
      ],
    );
  }
}
