import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/widgets/app_error_view.dart';
import 'package:flutter_template/core/widgets/app_loading.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    required this.value,
    required this.data,
    super.key,
    this.loading,
    this.onRetry,
  });

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget? loading;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => loading ?? const AppLoadingWidget(mode: AppLoadingMode.shimmer),
      error: (error, _) => AppErrorView(
        message: error.toString(),
        onRetry: onRetry,
      ),
    );
  }
}
