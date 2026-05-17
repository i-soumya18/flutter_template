import 'package:flutter/widgets.dart';

class AppBorderRadius {
  const AppBorderRadius._();

  static const small = Radius.circular(8);
  static const medium = Radius.circular(16);
  static const large = Radius.circular(24);

  static const smallAll = BorderRadius.all(small);
  static const mediumAll = BorderRadius.all(medium);
  static const largeAll = BorderRadius.all(large);
}
