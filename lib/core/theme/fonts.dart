import 'package:flutter/material.dart';

import 'colors.dart';

class FontsApp {
  static const titleLargeSize = 24.0;
  static const titleMediumSize = 16.0;

  static TextTheme textTheme = const TextTheme().copyWith(
    titleLarge: const TextStyle(
        fontSize: titleLargeSize,
        fontWeight: FontWeight.bold,
        color: ColorsApp.dark),
    titleMedium: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: titleMediumSize,
        letterSpacing: 1.0),
  );
}
