import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart';


class BlobUrlHelper {
  // Store URLs to manage lifecycle
  final Map<String, String> _activeUrls = {};

  /// Converts a blob to a URL that can be used by video players
  /// Returns null if not running on web
  String? createUrlFromBlob(dynamic blob, {String mimeType = 'video/mp4'}) {
    if (!kIsWeb) return null;

    try {
      // Create blob with proper MIME type
      final blobData = html.Blob([blob], mimeType);
      final url = html.Url.createObjectUrlFromBlob(blobData);

      // Store URL for cleanup
      _activeUrls[blob.toString()] = url;

      return url;
    } catch (e) {
      print('Error creating URL from blob: $e');
      return null;
    }
  }

  /// Revokes a specific URL
  void revokeUrl(dynamic blob) {
    if (!kIsWeb) return;

    final key = blob.toString();
    final url = _activeUrls[key];
    if (url != null) {
      html.Url.revokeObjectUrl(url);
      _activeUrls.remove(key);
    }
  }

  /// Revokes all active URLs
  void revokeAllUrls() {
    if (!kIsWeb) return;

    _activeUrls.values.forEach(html.Url.revokeObjectUrl);
    _activeUrls.clear();
  }

  /// Checks if a URL is still active
  bool isUrlActive(dynamic blob) {
    return _activeUrls.containsKey(blob.toString());
  }

  /// Disposes of all URLs and clears the helper
  void dispose() {
    revokeAllUrls();
  }
}