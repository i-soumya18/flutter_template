import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/features/splash/presentation/providers/splash_provider.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _wordmarkOpacity;
  late final Animation<double> _wordmarkOffsetY;
  late final Animation<double> _taglineOpacity;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 980),
    );

    _logoScale = Tween<double>(begin: 0.85, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.122, 0.408, curve: Curves.elasticOut),
      ),
    );

    _logoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.306, 0.51, curve: Curves.easeOut),
      ),
    );

    _wordmarkOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.51, 0.714, curve: Curves.easeOut),
      ),
    );

    _wordmarkOffsetY = Tween<double>(begin: 8, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.51, 0.714, curve: Curves.easeOutCubic),
      ),
    );

    _taglineOpacity = Tween<double>(begin: 0, end: 0.55).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.714, 0.918, curve: Curves.easeOut),
      ),
    );

    _controller.forward().whenComplete(_navigateNext);
  }

  Future<void> _navigateNext() async {
    final route = await ref.read(splashNextRouteProvider.future);
    if (!mounted) return;
    context.go(route);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  scale: _logoScale.value,
                  child: Opacity(
                    opacity: _logoOpacity.value,
                    child: Icon(
                      Icons.flutter_dash_rounded,
                      size: 84,
                      color: colors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Transform.translate(
                  offset: Offset(0, _wordmarkOffsetY.value),
                  child: Opacity(
                    opacity: _wordmarkOpacity.value,
                    child: const Text(
                      'Rite Labs',
                      style: TextStyle(
                        fontFamily: 'ClashDisplay',
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Opacity(
                  opacity: _taglineOpacity.value,
                  child: const Text(
                    'Build what lasts.',
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
