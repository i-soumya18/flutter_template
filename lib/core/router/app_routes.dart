import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  const AppRoutes._();

  static CustomTransitionPage<T> fadePage<T>({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  static CustomTransitionPage<T> slidePage<T>({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionsBuilder: (_, animation, __, child) {
        final tween = Tween(
          begin: const Offset(0.08, 0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutCubic));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

