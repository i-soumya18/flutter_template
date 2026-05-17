import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_template/core/errors/failure.dart';

class ErrorHandler {
  const ErrorHandler._();

  static Failure map(Object error) {
    if (error is DioException) {
      return NetworkFailure(error.message ?? 'Network error');
    }
    if (error is FirebaseAuthException) {
      return AuthFailure(error.message ?? 'Authentication failed', code: error.code);
    }
    return Failure(error.toString());
  }
}
