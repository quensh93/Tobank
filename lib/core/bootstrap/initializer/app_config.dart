class AppConfig {
  static const String _themeKey = 'theme_mode';
  static const String _languageKey = 'language';
  static const String _firstLaunchKey = 'first_launch';
  
  static Future<void> initialize(Map<String, dynamic> prefs) async {
    // Initialize app configuration
    // Set default values if they don't exist
    prefs[_firstLaunchKey] = prefs[_firstLaunchKey] ?? true;
  }
  
  static bool isFirstLaunch(Map<String, dynamic> prefs) {
    return prefs[_firstLaunchKey] ?? true;
  }
  
  static Future<void> setFirstLaunchComplete(Map<String, dynamic> prefs) async {
    prefs[_firstLaunchKey] = false;
  }
  
  static String getThemeMode(Map<String, dynamic> prefs) {
    return prefs[_themeKey] ?? 'system';
  }
  
  static Future<void> setThemeMode(Map<String, dynamic> prefs, String mode) async {
    prefs[_themeKey] = mode;
  }
  
  static String getLanguage(Map<String, dynamic> prefs) {
    return prefs[_languageKey] ?? 'en';
  }
  
  static Future<void> setLanguage(Map<String, dynamic> prefs, String language) async {
    prefs[_languageKey] = language;
  }
}
