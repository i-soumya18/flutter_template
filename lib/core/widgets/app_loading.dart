import 'package:flutter/material.dart';
import 'package:flutter_template/core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

enum AppLoadingMode { shimmer, spinner }

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({
    super.key,
    this.mode = AppLoadingMode.spinner,
    this.height = 80,
    this.width = double.infinity,
  });

  final AppLoadingMode mode;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    if (mode == AppLoadingMode.spinner) {
      return const Center(
        child: SizedBox.square(
          dimension: 28,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        ),
      );
    }

    final brightness = Theme.of(context).brightness;
    final colors = brightness == Brightness.dark ? AppColors.dark : AppColors.light;

    return Shimmer.fromColors(
      baseColor: colors.shimmerBase,
      highlightColor: colors.shimmerHighlight,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: colors.shimmerBase,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
