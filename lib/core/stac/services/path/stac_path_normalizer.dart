/// Service for normalizing asset paths and converting them to API URLs.
/// 
/// Follows Single Responsibility Principle - only responsible for path
/// normalization and conversion.
class StacPathNormalizer {
  StacPathNormalizer._();

  /// Normalizes asset paths by handling old paths like "stac/.build/..." 
  /// and converting them to "lib/stac/.build/...".
  static String normalizeAssetPath(String path) {
    if (path.startsWith('stac/')) {
      return 'lib/$path';
    }
    return path;
  }

  /// Converts an asset path to an API URL format that the mock interceptor recognizes.
  /// 
  /// Examples:
  /// - `lib/stac/tobank/login/api/GET_tobank_login.json` -> `https://api.tobank.com/login/tobank_login`
  /// - `lib/stac/tobank/menu/api/GET_menu-items.json` -> `https://api.tobank.com/menu/menu-items`
  static String? convertAssetPathToApiUrl(String normalizedPath) {
    if (!normalizedPath.contains('/api/GET_')) {
      return null; // Not an API file
    }

    String apiPath;
    if (normalizedPath.contains('lib/stac/tobank/')) {
      // New structure: lib/stac/tobank/login/api/GET_tobank_login.json
      // Extract: login/api/GET_tobank_login.json -> login/tobank_login
      final match = RegExp(r'lib/stac/tobank/([^/]+)/api/GET_(.+)\.json')
          .firstMatch(normalizedPath);
      if (match != null) {
        final feature = match.group(1)!;
        final screen = match.group(2)!;
        apiPath = '$feature/$screen';
      } else {
        // Fallback: simple replacement
        apiPath = normalizedPath
            .replaceAll('lib/stac/tobank/', '')
            .replaceAll('/api/GET_', '/')
            .replaceAll('.json', '');
      }
    } else {
      // Fallback: simple replacement for any other structure
      apiPath = normalizedPath
          .replaceAll('lib/stac/tobank/', '')
          .replaceAll('/api/GET_', '/')
          .replaceAll('GET_', '')
          .replaceAll('.json', '');
    }
    
    return 'https://api.tobank.com/$apiPath';
  }

  /// Checks if a path is an API file (contains /api/GET_).
  static bool isApiFile(String path) {
    return path.contains('/api/GET_');
  }
}
