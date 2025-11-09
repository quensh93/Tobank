/// App-wide constants and configuration values
class AppConstants {
  AppConstants._();

  // App Information
  static const String appName = 'Tobank Sdui';
  static const String appVersion = '1.0.0';
  static const String appPackageName = 'com.tobank.sdui';

  // API Configuration
  static const String baseUrl = 'https://httpbin.org/';
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration apiConnectTimeout = Duration(seconds: 30);

  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String userEmailKey = 'user_email';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // DateTime Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm:ss';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';

  // Regex Patterns
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phonePattern = r'^\+?[1-9]\d{1,14}$';

  // Limits
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
}
