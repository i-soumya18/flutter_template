import 'package:flutter/material.dart';

class AppShadows {
  const AppShadows._();

  static const sm = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const md = [
    BoxShadow(
      color: Color(0x1F000000),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];
}
