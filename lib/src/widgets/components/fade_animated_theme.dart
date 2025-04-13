import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Animated version of [Theme] which automatically transitions the colors,
/// etc, over a given duration whenever the given theme changes.
class FadeAnimatedTheme extends ImplicitlyAnimatedWidget {
  /// Creates an animated theme.
  ///
  /// By default, the theme transition uses a linear curve. The [data] and
  /// [child] arguments must not be null.
  const FadeAnimatedTheme({
    super.key,
    required this.data,
    this.isMaterialAppTheme = false,
    super.curve,
    super.duration = kThemeAnimationDuration,
    super.onEnd,
    required this.child,
  });

  /// Specifies the color and typography values for descendant widgets.
  final ThemeData data;

  /// True if this theme was created by the [MaterialApp]. See [Theme.isMaterialAppTheme].
  final bool isMaterialAppTheme;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  @override
  FadeAnimatedThemeState createState() => FadeAnimatedThemeState();
}

class FadeAnimatedThemeState
    extends AnimatedWidgetBaseState<FadeAnimatedTheme> {
  ThemeDataTween? _data;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _data =
        visitor(
              _data,
              widget.data,
              (dynamic value) => ThemeDataTween(begin: value),
            )!
            as ThemeDataTween?;
    assert(_data != null);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(data: _data!.evaluate(animation), child: widget.child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<ThemeDataTween>(
        'data',
        _data,
        showName: false,
        defaultValue: null,
      ),
    );
  }
}
