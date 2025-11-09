import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'theme_controller_provider.g.dart';

/// Provider that manages the app's theme mode (light/dark)
@riverpod
class ThemeController extends _$ThemeController {
  static const String _themeModeKey = 'theme_mode';
  final _storage = const FlutterSecureStorage();

  @override
  Future<ThemeMode> build() async {
    // Load saved theme mode from secure storage
    final savedMode = await _storage.read(key: _themeModeKey);
    
    if (savedMode == null) {
      return ThemeMode.system;
    }
    
    switch (savedMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  /// Set the theme mode and persist it to storage
  Future<void> setMode(ThemeMode mode) async {
    state = AsyncValue.data(mode);
    
    String modeString;
    switch (mode) {
      case ThemeMode.light:
        modeString = 'light';
        break;
      case ThemeMode.dark:
        modeString = 'dark';
        break;
      case ThemeMode.system:
        modeString = 'system';
        break;
    }
    
    await _storage.write(key: _themeModeKey, value: modeString);
  }

  /// Toggle between light and dark mode
  Future<void> toggleMode() async {
    final currentMode = state.value ?? ThemeMode.system;
    final newMode = currentMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    await setMode(newMode);
  }
}
