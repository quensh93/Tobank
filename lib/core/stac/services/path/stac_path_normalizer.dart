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
  /// - `lib/stac/tobank/flows/login_flow_linear/api/GET_login_flow_linear_splash.json` -> `https://api.tobank.com/flows/login_flow_linear/login_flow_linear_splash`
  static String? convertAssetPathToApiUrl(String normalizedPath) {
    if (!normalizedPath.contains('/api/GET_')) {
      return null; // Not an API file
    }

    String apiPath;
    if (normalizedPath.contains('lib/stac/tobank/')) {
      // Special handling for flows (contains flows/ in path)
      if (normalizedPath.contains('/flows/')) {
        // Pattern: lib/stac/tobank/flows/login_flow_linear/api/GET_login_flow_linear_splash.json
        // Extract: flows/login_flow_linear/api/GET_login_flow_linear_splash.json -> flows/login_flow_linear/login_flow_linear_splash
        final match = RegExp(r'lib/stac/tobank/flows/([^/]+)/api/GET_(.+)\.json')
            .firstMatch(normalizedPath);
        if (match != null) {
          final flowName = match.group(1)!; // e.g., 'login_flow_linear'
          final screen = match.group(2)!; // e.g., 'login_flow_linear_splash'
          apiPath = 'flows/$flowName/$screen';
        } else {
          // Fallback: simple replacement for flows
          apiPath = normalizedPath
              .replaceAll('lib/stac/tobank/', '')
              .replaceAll('/api/GET_', '/')
              .replaceAll('.json', '');
        }
      } else {
        // Regular feature: lib/stac/tobank/login/api/GET_tobank_login.json
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
