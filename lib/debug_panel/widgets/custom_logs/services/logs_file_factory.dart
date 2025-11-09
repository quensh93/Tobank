import 'package:ispect/ispect.dart';

/// Factory class for creating platform-appropriate log file handlers.
///
/// Automatically selects the correct implementation based on the platform:
/// - **Native platforms** (Android, iOS, macOS, Windows, Linux): Uses file system
/// - **Web platform**: Uses browser Blob API
class LogsFileFactory {
  const LogsFileFactory._();

  /// Convenience method to directly download/share a log file.
  ///
  /// **Platform-specific behavior:**
  /// - **Web**: Triggers browser download
  /// - **Native**: Opens share dialog
  ///
  /// **Parameters:**
  /// - [logs]: The log content to download/share
  /// - [fileName]: Base name for the file (default: 'ispect_all_logs')
  ///
  /// **Example:**
  /// ```dart
  /// // Works on all platforms
  /// await LogsFileFactory.downloadFile('My logs content', fileName: 'my_logs');
  /// ```
  static Future<void> downloadFile(
    String logs, {
    String fileName = 'ispect_all_logs',
    String fileType = 'json',
    ISpectShareCallback? onShare,
  }) async {
    // Use ISpect's built-in share functionality
    // This will use the platform-appropriate implementation
    if (onShare != null) {
      await onShare(
        ISpectShareRequest(
          text: logs,
          subject: '$fileName.$fileType',
        ),
      );
    }
  }
}

