import 'package:flutter/material.dart';
import '../../presentation/presentation.dart';

class RoutesApp {
  static const String home = 'home';
  static const String detail = 'detail';
  static const String search = 'search';

  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
    home: (context) => const SplashScreen(),
    detail: (context) => const DetailScreen(),
    search: (context) => const SearchScreen()
  };
}
