import 'package:fav_test_task/src/bl/helpers/app_theme.dart';
import 'package:fav_test_task/src/bl/notifier/change_theme_notifier.dart';
import 'package:fav_test_task/src/bl/notifier/shared_preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ChangeThemeNotifier, ThemeData>(
  (ref) => ChangeThemeNotifier(
    themeSelect: AppTheme(),
    sharedPreferences: ref.watch(sharedPreferencesProvider),
  ),
);
