import 'package:fav_test_task/src/bl/abstractions/main_theme_abstraction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This class is a [StateNotifier] that manages the theme of the application.
/// It extends the [StateNotifier] class from the Riverpod package.
class ChangeThemeNotifier extends StateNotifier<ThemeData> {
  final SharedPreferences sharedPreferences;
  final MainThemeAbstraction themeSelect;
  static const _themeKey = 'isDarkTheme';

  /// Constructs a [ChangeThemeNotifier]
  ChangeThemeNotifier({
    required this.themeSelect,
    required this.sharedPreferences,
  }) : super(themeSelect.lightTheme) {
    _loadThemeFromPreferences();
  }

  /// Gets the current theme mode
  ThemeMode get themeMode =>
      state == themeSelect.lightTheme ? ThemeMode.light : ThemeMode.dark;

  /// Initializes the theme from SharedPreferences
  Future<void> _loadThemeFromPreferences() async {
    final isDarkTheme = sharedPreferences.getBool(_themeKey) ?? false;
    state = isDarkTheme ? themeSelect.darkTheme : themeSelect.lightTheme;
  }

  /// Toggles the theme and saves it to SharedPreferences
  Future<void> toggleTheme() async {
    final isDarkTheme = themeMode == ThemeMode.light;
    state = isDarkTheme ? themeSelect.darkTheme : themeSelect.lightTheme;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDarkTheme);
  }
}
