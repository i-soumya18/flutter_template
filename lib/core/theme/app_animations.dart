import 'package:flutter/animation.dart';

class AppAnimations {
  const AppAnimations._();

  static const fast = Duration(milliseconds: 200);
  static const medium = Duration(milliseconds: 300);
  static const slow = Duration(milliseconds: 500);

  static const emphasized = Curves.easeOutCubic;
  static const standard = Curves.easeInOut;
  static const spring = Curves.elasticOut;
}
