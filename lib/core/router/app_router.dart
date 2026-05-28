import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/config/app_config.dart';
import 'package:flutter_template/core/constants/route_constants.dart';
import 'package:flutter_template/core/router/app_routes.dart';
import 'package:flutter_template/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_template/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:flutter_template/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_template/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter_template/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter_template/features/dashboard/presentation/widgets/dashboard_scaffold.dart';
import 'package:flutter_template/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:flutter_template/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter_template/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter_template/features/splash/presentation/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  ref.watch(authStateProvider);
  return GoRouter(
    initialLocation: RouteConstants.splash,
    redirect: (context, state) {
      final isAuthenticated = ref.read(isAuthenticatedProvider);
      final location = state.matchedLocation;

      const authPaths = {
        RouteConstants.login,
        RouteConstants.register,
        RouteConstants.forgotPassword,
      };

      if (location == RouteConstants.splash ||
          location == RouteConstants.onboarding) {
        return null;
      }
      if (!AppConfig.hasFirebaseConfig) {
        return authPaths.contains(location) ? RouteConstants.dashboard : null;
      }
      if (!isAuthenticated && !authPaths.contains(location)) {
        return RouteConstants.login;
      }
      if (isAuthenticated && authPaths.contains(location)) {
        return RouteConstants.dashboard;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: RouteConstants.splash,
        pageBuilder: (context, state) => AppRoutes.fadePage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: RouteConstants.onboarding,
        pageBuilder: (context, state) => AppRoutes.fadePage(
          key: state.pageKey,
          child: const OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: RouteConstants.login,
        pageBuilder: (context, state) => AppRoutes.fadePage(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: RouteConstants.register,
        pageBuilder: (context, state) => AppRoutes.slidePage(
          key: state.pageKey,
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: RouteConstants.forgotPassword,
        pageBuilder: (context, state) => AppRoutes.slidePage(
          key: state.pageKey,
          child: const ForgotPasswordScreen(),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) => DashboardScaffold(child: child),
        routes: [
          GoRoute(
            path: RouteConstants.dashboard,
            pageBuilder: (context, state) => AppRoutes.fadePage(
              key: state.pageKey,
              child: const DashboardScreen(tab: DashboardTab.home),
            ),
          ),
          GoRoute(
            path: RouteConstants.explore,
            pageBuilder: (context, state) => AppRoutes.fadePage(
              key: state.pageKey,
              child: const DashboardScreen(tab: DashboardTab.explore),
            ),
          ),
          GoRoute(
            path: RouteConstants.activity,
            pageBuilder: (context, state) => AppRoutes.fadePage(
              key: state.pageKey,
              child: const DashboardScreen(tab: DashboardTab.activity),
            ),
          ),
          GoRoute(
            path: RouteConstants.profile,
            pageBuilder: (context, state) => AppRoutes.fadePage(
              key: state.pageKey,
              child: const ProfileScreen(),
            ),
          ),
          GoRoute(
            path: RouteConstants.settings,
            pageBuilder: (context, state) => AppRoutes.slidePage(
              key: state.pageKey,
              child: const SettingsScreen(),
            ),
            routes: [
              GoRoute(
                path: 'appearance',
                pageBuilder: (context, state) => AppRoutes.slidePage(
                  key: state.pageKey,
                  child: const _SettingsDetailScreen(title: 'Appearance'),
                ),
              ),
              GoRoute(
                path: 'notifications',
                pageBuilder: (context, state) => AppRoutes.slidePage(
                  key: state.pageKey,
                  child: const _SettingsDetailScreen(title: 'Notifications'),
                ),
              ),
              GoRoute(
                path: 'account',
                pageBuilder: (context, state) => AppRoutes.slidePage(
                  key: state.pageKey,
                  child: const _SettingsDetailScreen(title: 'Account'),
                ),
              ),
              GoRoute(
                path: 'about',
                pageBuilder: (context, state) => AppRoutes.slidePage(
                  key: state.pageKey,
                  child: const _SettingsDetailScreen(title: 'About'),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (_, __) => const _NotFoundScreen(),
  );
});

class _SettingsDetailScreen extends StatelessWidget {
  const _SettingsDetailScreen({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('$title settings')),
    );
  }
}

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '404 - Page not found',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
