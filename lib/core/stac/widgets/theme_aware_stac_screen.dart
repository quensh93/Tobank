import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../../features/pre_launch/providers/theme_controller_provider.dart';

/// A wrapper widget that makes any STAC screen reactive to theme changes.
///
/// When the theme toggles, this widget rebuilds and re-parses the STAC JSON
/// with the updated color registry values.
class ThemeAwareStacScreen extends ConsumerWidget {
  const ThemeAwareStacScreen({super.key, required this.stacWidgetBuilder});

  /// Function that returns the StacWidget to render.
  /// This is called each time the widget rebuilds (e.g., on theme change).
  final StacWidget Function() stacWidgetBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the theme controller - this triggers rebuild when theme changes
    final themeState = ref.watch(themeControllerProvider);

    // Log for debugging
    final themeMode = themeState.maybeWhen(
      data: (mode) => mode,
      orElse: () => ThemeMode.system,
    );
    debugPrint(
      '🎨 ThemeAwareStacScreen rebuilding with theme: ${themeMode.name}',
    );

    // Build the STAC widget and convert to JSON
    final stacWidget = stacWidgetBuilder();
    final json = stacWidget.toJson();

    // Parse and render the STAC JSON with current registry values
    final rendered = Stac.fromJson(json, context) ?? const SizedBox.shrink();

    return rendered;
  }
}

/// Extension to easily wrap any StacWidget function with theme awareness
extension ThemeAwareStacWidgetExtension on StacWidget Function() {
  /// Wrap this StacWidget builder in a theme-aware widget that rebuilds on theme change
  Widget asThemeAware() {
    return ThemeAwareStacScreen(stacWidgetBuilder: this);
  }
}
