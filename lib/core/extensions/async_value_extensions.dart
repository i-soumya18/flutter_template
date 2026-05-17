import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueExtensions<T> on AsyncValue<T> {
  bool get isLoadingOrRefreshing => isLoading || isRefreshing;

  T? get dataOrNull => maybeWhen(
        data: (value) => value,
        orElse: () => null,
      );

  String? errorMessage() => whenOrNull(
        error: (error, _) => error.toString(),
      );

  Widget maybeMapWidget({
    required Widget Function(T data) data,
    required Widget loading,
    required Widget Function(Object error) error,
  }) {
    return when(
      data: data,
      loading: () => loading,
      error: (err, _) => error(err),
    );
  }
}
