import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stac/stac.dart';
import 'package:tobank_sdui/core/helpers/logger.dart';
import 'package:tobank_sdui/features/pre_launch/providers/theme_controller_provider.dart';
import 'package:tobank_sdui/core/stac/registry/custom_component_registry.dart';
import 'theme_toggle_action_model.dart';

class ThemeToggleActionParser extends StacActionParser<ThemeToggleActionModel> {
  const ThemeToggleActionParser();

  @override
  String get actionType => 'toggleTheme';

  @override
  ThemeToggleActionModel getModel(Map<String, dynamic> json) =>
      ThemeToggleActionModel.fromJson(json);

  @override
  FutureOr onCall(BuildContext context, ThemeToggleActionModel model) async {
    try {
      // Access Riverpod container from context
      final container = ProviderScope.containerOf(context);

      // Get current mode for logging
      final currentMode = container
          .read(themeControllerProvider)
          .maybeWhen(data: (mode) => mode, orElse: () => ThemeMode.system);
      AppLogger.i('🌓 ThemeToggle: Switching from ${currentMode.name} theme');

      // Toggle theme
      await container.read(themeControllerProvider.notifier).toggleMode();

      final newMode = container
          .read(themeControllerProvider)
          .maybeWhen(data: (mode) => mode, orElse: () => ThemeMode.system);
      AppLogger.i('🌓 ThemeToggle: New mode is ${newMode.name} theme');
    } catch (e, stackTrace) {
      AppLogger.e('❌ ThemeToggle: Failed to toggle theme', e, stackTrace);
    }
  }
}

void registerThemeToggleActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ThemeToggleActionParser(),
  );
}
