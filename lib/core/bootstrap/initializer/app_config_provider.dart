import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'app_config.dart';

// Provider for preferences
final sharedPreferencesProvider = Provider<Map<String, dynamic>>((ref) {
  throw UnimplementedError('Preferences must be overridden');
});

// Provider for app configuration
final appConfigProvider = Provider<AppConfigProvider>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AppConfigProvider(prefs);
});

class AppConfigProvider {
  final Map<String, dynamic> _prefs;
  
  AppConfigProvider(this._prefs);
  
  bool get isFirstLaunch => AppConfig.isFirstLaunch(_prefs);
  String get themeMode => AppConfig.getThemeMode(_prefs);
  String get language => AppConfig.getLanguage(_prefs);
  
  Future<void> setFirstLaunchComplete() async {
    await AppConfig.setFirstLaunchComplete(_prefs);
  }
  
  Future<void> setThemeMode(String mode) async {
    await AppConfig.setThemeMode(_prefs, mode);
  }
  
  Future<void> setLanguage(String language) async {
    await AppConfig.setLanguage(_prefs, language);
  }
}
