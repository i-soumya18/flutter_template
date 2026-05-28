import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/config/app_config.dart';
import 'package:flutter_template/core/constants/route_constants.dart';
import 'package:flutter_template/core/constants/storage_keys.dart';
import 'package:flutter_template/core/network/api_client.dart';
import 'package:flutter_template/features/auth/presentation/providers/auth_provider.dart';

final splashNextRouteProvider = FutureProvider<String>((ref) async {
  final firstLaunch = await ref
      .read(storageServiceProvider)
      .readBool(StorageKeys.isFirstLaunch);
  final isAuthenticated = ref.read(isAuthenticatedProvider);

  if (firstLaunch ?? true) return RouteConstants.onboarding;
  if (!AppConfig.hasFirebaseConfig) return RouteConstants.dashboard;
  if (isAuthenticated) return RouteConstants.dashboard;
  return RouteConstants.login;
});
