import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/config/app_config.dart';
import 'package:flutter_template/core/network/auth_interceptor.dart';
import 'package:flutter_template/core/services/storage_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final storageServiceProvider = Provider<StorageService>((_) => StorageService());

final dioProvider = Provider<Dio>((ref) {
  final storage = ref.watch(storageServiceProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );
  dio.interceptors.addAll([
    AuthInterceptor(storage),
    PrettyDioLogger(requestBody: true, responseBody: true),
  ]);
  return dio;
});
