import 'package:fav_test_task/src/bl/providers/theme_provider.dart';
import 'package:fav_test_task/src/widgets/components/fade_animated_theme.dart';
import 'package:fav_test_task/src/widgets/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The main entry point of the application.
/// It initializes the app and sets up the routing and theming.
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Movies List',
      builder:
          (context, child) => ScaffoldMessenger(
            child: FadeAnimatedTheme(
              data: ref.watch(themeProvider),
              child: child!,
            ),
          ),
      routerConfig: router,
    );
  }
}
