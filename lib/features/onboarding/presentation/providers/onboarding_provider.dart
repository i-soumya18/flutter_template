import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/features/onboarding/data/models/onboarding_page_model.dart';

final onboardingPagesProvider = Provider<List<OnboardingPageModel>>(
  (_) => const [
    OnboardingPageModel(
      title: 'Welcome to Rite Labs',
      subtitle: 'Build products with a polished production-ready template.',
      animationAsset: 'assets/animations/onboarding_1.json',
    ),
    OnboardingPageModel(
      title: 'Ship faster',
      subtitle: 'Opinionated architecture, reusable widgets, and clean routing.',
      animationAsset: 'assets/animations/onboarding_2.json',
    ),
    OnboardingPageModel(
      title: 'Scale confidently',
      subtitle: 'Strong foundations for auth, settings, docs, and theming.',
      animationAsset: 'assets/animations/onboarding_3.json',
    ),
  ],
);
