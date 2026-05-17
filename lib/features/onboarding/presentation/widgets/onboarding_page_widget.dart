import 'package:flutter/material.dart';
import 'package:flutter_template/features/onboarding/data/models/onboarding_page_model.dart';
import 'package:lottie/lottie.dart';

class OnboardingPageWidget extends StatelessWidget {
  const OnboardingPageWidget({required this.page, super.key});

  final OnboardingPageModel page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Lottie.asset(
              page.animationAsset,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.animation_outlined,
                size: 120,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            page.title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            page.subtitle,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
