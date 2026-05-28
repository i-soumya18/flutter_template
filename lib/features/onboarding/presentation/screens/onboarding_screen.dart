import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/config/app_config.dart';
import 'package:flutter_template/core/constants/route_constants.dart';
import 'package:flutter_template/core/constants/storage_keys.dart';
import 'package:flutter_template/core/network/api_client.dart';
import 'package:flutter_template/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:flutter_template/features/onboarding/presentation/widgets/onboarding_page_widget.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  final _currentPage = ValueNotifier<int>(0);

  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  Future<void> _complete() async {
    await ref
        .read(storageServiceProvider)
        .writeBool(StorageKeys.isFirstLaunch, false);
    if (!mounted) return;
    context.go(
      AppConfig.hasFirebaseConfig
          ? RouteConstants.login
          : RouteConstants.dashboard,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = ref.watch(onboardingPagesProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _complete,
                child: const Text('Skip'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) => _currentPage.value = index,
                itemBuilder: (context, index) =>
                    OnboardingPageWidget(page: pages[index]),
              ),
            ),
            ValueListenableBuilder<int>(
              valueListenable: _currentPage,
              builder: (context, index, _) {
                final isLast = index == pages.length - 1;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          pages.length,
                          (dotIndex) => AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: dotIndex == index ? 18 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: dotIndex == index
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context)
                                      .colorScheme
                                      .outlineVariant,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () async {
                          if (isLast) {
                            await _complete();
                            return;
                          }
                          await _pageController.nextPage(
                            duration: const Duration(milliseconds: 280),
                            curve: Curves.easeOutCubic,
                          );
                        },
                        child: Text(isLast ? 'Get Started' : 'Next'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
