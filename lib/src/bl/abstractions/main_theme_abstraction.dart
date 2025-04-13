import 'package:flutter/material.dart';

/// This is an abstract class that defines the structure for a theme abstraction
/// in a Flutter application. It contains two getters: `lightTheme` and `darkTheme`,
abstract class MainThemeAbstraction {
  ThemeData get lightTheme;
  ThemeData get darkTheme;
}
