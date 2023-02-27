import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

class ThemeApp {
  static ThemeData themeData = ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme().copyWith(
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: FontsApp.textTheme,
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(color: ColorsApp.scaffold),
      ));
}
