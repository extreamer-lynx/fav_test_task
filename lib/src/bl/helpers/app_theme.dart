import 'package:fav_test_task/src/bl/abstractions/main_theme_abstraction.dart';
import 'package:flutter/material.dart';

/// This class implements the [MainThemeAbstraction] interface.
/// It provides two themes: light and dark, using Material 3 design principles.
class AppTheme implements MainThemeAbstraction {
  @override
  ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xFF6750A4),
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFDF6E4),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFDF6E4),
      foregroundColor: Color(0xFF1C1B1F),
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
      labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
      labelSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
    ),
  );

  @override
  ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xFF6750A4),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1C1B1F),
    textTheme: TextTheme(
      headlineMedium: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
      labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
      labelSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1C1B1F),
      foregroundColor: Color(0xFFFDF6E4),
    ),
  );
}
