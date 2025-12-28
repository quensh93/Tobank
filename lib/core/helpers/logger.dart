import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:ispect/ispect.dart';
import 'package:flutter/scheduler.dart';
import 'log_category.dart';

export 'log_category.dart';

/// A conditional print function that respects the global log settings.
/// Use this instead of print() or debugPrint() for debug logs that should
/// be disabled when the master log toggle is off.
void conditionalPrint(String message) {
  if (Logger.level != Level.off) {
    // ignore: avoid_print
    print(message);
  }
}

/// Helper class to store log data for deferred processing
class _LogLine {
  final Level level;
  final String message;

  _LogLine({required this.level, required this.message});
}

/// Strips ANSI escape codes from a string
///
/// ANSI escape codes are used for terminal text formatting (colors, styles, etc.)
/// but should not appear in UI logs. This function removes all ANSI escape sequences.
///
/// Handles both formats:
/// - With escape character: \x1B[38;5;12m or \u001B[0m
/// - Without escape character (already processed): [38;5;12m or [0m
String _stripAnsiCodes(String text) {
  // First, remove ANSI codes with escape character (\x1B or \u001B)
  var cleaned = text.replaceAll(RegExp(r'\x1B\[[0-9;]*[a-zA-Z]'), '');
  cleaned = cleaned.replaceAll(RegExp(r'\u001B\[[0-9;]*[a-zA-Z]'), '');

  // Then, remove standalone ANSI codes (brackets with codes, no escape char)
  // Pattern: [ followed by digits/semicolons, ending with a letter
  // Examples: [38;5;12m, [0m, [1m, [2J, [K
  cleaned = cleaned.replaceAll(RegExp(r'\[[0-9;]*[a-zA-Z]'), '');

  return cleaned;
}

/// Checks if a cleaned line is purely decorative (border/divider)
///
/// This detects lines that are:
/// - Empty or whitespace only
/// - Composed entirely of box-drawing characters (┌, └, ├, ┄, │, ─)
/// - Composed entirely of hyphens/dashes (common divider pattern)
/// - Composed entirely of equals signs (common divider pattern)
/// - Lines that start with box-drawing characters followed by many dashes
///
/// Note: Our custom separator "──" (two dashes) is explicitly allowed (not filtered).
/// Stack trace lines (starting with #) are explicitly allowed (not filtered).
///
/// [cleanedLine] should already have ANSI codes stripped and be trimmed.
bool _isDecorativeLine(String cleanedLine) {
  if (cleanedLine.isEmpty) return true;

  // Allow our custom separator pattern (exactly two dashes)
  // Pattern: "──" (exactly two dashes)
  if (cleanedLine == '──') return false;

  // Allow stack trace lines (they start with # followed by a number)
  // Pattern: "#0   LogIO.d (package:stac_logger/src/log_io.dart:16:35)"
  // Also allow file-only lines like "log_io.dart:16" that appear in stack traces
  if (RegExp(r'^#\d+').hasMatch(cleanedLine)) return false;
  if (RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*\.dart:\d+$').hasMatch(cleanedLine)) {
    return false;
  }

  // Check for box-drawing characters (Unicode box-drawing set)
  // This matches lines like: └───────────────────────────────────────────
  if (RegExp(r'^[┌└├┄│─\s]+$').hasMatch(cleanedLine)) {
    // If it's all box-drawing chars but not our separator, it's decorative
    if (cleanedLine != '──') return true;
  }

  // Check for simple divider patterns (regular hyphens, equals, underscores WITHOUT spaces)
  // These are common in logger output for separators
  // Match lines with 3+ repeated characters WITHOUT spaces (pure dividers)
  // But exclude our separator (exactly two dashes) which we already allowed above
  if (RegExp(r'^[-=_]{3,}$').hasMatch(cleanedLine)) return true;

  // Check for lines that start with box-drawing char followed by many dashes
  // Pattern: box-drawing char at start, then many dashes/hyphens
  if (RegExp(r'^[┌└├┄│][─\-]{10,}$').hasMatch(cleanedLine)) return true;

  return false;
}

/// Cleans and processes a log line for ISpect display
///
/// This function:
/// 1. Strips ANSI escape codes
/// 2. Trims whitespace
/// 3. Filters out decorative/boilerplate lines
String? _cleanLogLine(String line) {
  // Strip ANSI codes first
  final cleaned = _stripAnsiCodes(line).trim();

  // Skip empty lines
  if (cleaned.isEmpty) return null;

  // Skip decorative/boilerplate lines (pass already-cleaned string)
  if (_isDecorativeLine(cleaned)) return null;

  return cleaned;
}

/// Custom LogOutput that forwards logs to ISpect logger
///
/// This allows AppLogger messages to appear in the debug panel's logs tab.
///
/// CRITICAL: Logging operations are deferred to after the build phase to prevent
/// "setState() called during build" errors. ISpect's logger triggers UI updates
/// via StreamBuilder, which cannot happen during widget build.
class ISpectLogOutput extends LogOutput {
  final LogOutput? _fallback;

  ISpectLogOutput({LogOutput? fallback}) : _fallback = fallback;

  @override
  void output(OutputEvent event) {
    // Output to fallback (console) - if it's BorderlessLogOutput, it will filter decorative lines
    // If it's ConsoleOutput directly, we still want clean output, so we'll filter here too
    if (_fallback != null) {
      // If fallback is BorderlessLogOutput, it will handle filtering
      // Otherwise, create a filtered event for console output
      final filteredLines = event.lines.where((line) {
        final cleaned = _cleanLogLine(line);
        return cleaned != null;
      }).toList();

      if (filteredLines.isNotEmpty) {
        _fallback.output(OutputEvent(event.origin, filteredLines));
      }
    }

    // Forward to ISpect logger if available, but defer to after build phase
    // This prevents "setState() called during build" errors
    try {
      // ISpect.logger is available globally after ISpect.init() is called
      // Check if ISpect is actually initialized before trying to use it
      final ispectLogger = ISpect.logger;

      // Verify ISpect is actually initialized (not just the logger getter available)
      // The getter might be available but ISpect might not be fully initialized yet

      // Prepare log data to forward (with cleaning and filtering)
      final logLines = <_LogLine>[];
      for (final line in event.lines) {
        // Clean the line (strip ANSI codes, filter decorative lines)
        final cleaned = _cleanLogLine(line);
        if (cleaned == null) continue; // Skip empty or decorative lines

        logLines.add(_LogLine(level: event.level, message: cleaned));
      }

      // If there are no log lines to forward, skip ISpect logging
      // This can happen if all lines were filtered out (decorative/empty)
      if (logLines.isEmpty) {
        return;
      }

      // Defer ISpect logging to after the current build phase completes
      // This prevents setState() calls during build
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _forwardToISpect(ispectLogger, logLines);
      });
    } catch (e) {
      // ISpect not initialized yet or not available - fallback to console only
      // This is expected during early app initialization
      // Intentionally swallow to avoid recursive logging
    }
  }

  /// Forward log lines to ISpect logger after build phase completes
  void _forwardToISpect(dynamic ispectLogger, List<_LogLine> logLines) {
    if (logLines.isEmpty) return;

    try {
      // Forward each log line to ISpect
      for (final logLine in logLines) {
        try {
          // Ensure message is not null or empty before forwarding
          if (logLine.message.isEmpty) continue;

          // For very long messages, ensure they're forwarded (ISpect should handle them)
          // No truncation - forward the full message

          bool forwarded = false;
          switch (logLine.level) {
            case Level.debug:
            case Level.trace:
            // ignore: deprecated_member_use
            case Level.verbose:
              // Try debug method, fallback to info if not available
              try {
                ispectLogger.debug(logLine.message);
                forwarded = true;
              } catch (e) {
                // If debug fails, try info as fallback
                try {
                  ispectLogger.info(logLine.message);
                  forwarded = true;
                } catch (e2) {
                  // Both failed - log error to console
                  forwarded = false;
                }
              }
              break;
            case Level.info:
              try {
                ispectLogger.info(logLine.message);
                forwarded = true;
              } catch (e) {
                forwarded = false;
              }
              break;
            case Level.warning:
              // Try warning method, fallback to info if not available
              try {
                ispectLogger.warning(logLine.message);
                forwarded = true;
              } catch (e) {
                try {
                  ispectLogger.info(logLine.message);
                  forwarded = true;
                } catch (e2) {
                  forwarded = false;
                }
              }
              break;
            case Level.error:
            case Level.fatal:
            // ignore: deprecated_member_use
            case Level.wtf:
              try {
                ispectLogger.error(logLine.message);
                forwarded = true;
              } catch (e) {
                forwarded = false;
              }
              break;
            case Level.all:
              // Level.all is used for filtering, not actual logging
              // Treat as info level
              try {
                ispectLogger.info(logLine.message);
                forwarded = true;
              } catch (e) {
                forwarded = false;
              }
              break;
            case Level.off:
            // ignore: deprecated_member_use
            case Level.nothing:
              // Level.nothing and Level.off mean no logging - skip this line
              continue;
          }

          // If forwarding failed for this line, log it for debugging
          if (!forwarded) {
            // Swallow to avoid recursive logging
          }
        } catch (e) {
          // Unexpected error - log to console as fallback
          // Swallow to avoid recursive logging
        }
      }
    } catch (e) {
      // ISpect logger error - log to console as fallback
      // Swallow to avoid recursive logging
    }
  }

  @override
  Future<void> destroy() async {
    await _fallback?.destroy();
  }
}

/// Custom LogOutput that filters out decorative border lines
///
/// This wrapper filters lines containing only box-drawing characters
/// (┌, └, ├, ┄, ─) and divider patterns to make logs cleaner.
/// Also strips ANSI escape codes before filtering.
class BorderlessLogOutput extends LogOutput {
  final LogOutput _wrapped;

  BorderlessLogOutput(this._wrapped);

  @override
  void output(OutputEvent event) {
    // Filter out decorative lines using the same cleaning logic as ISpectLogOutput
    final filteredLines = event.lines.where((line) {
      // Use the same cleaning function to ensure consistency
      final cleaned = _cleanLogLine(line);
      return cleaned != null; // Keep only non-null (non-decorative) lines
    }).toList();

    // Only output if there are meaningful lines left
    if (filteredLines.isNotEmpty) {
      // Create new OutputEvent with filtered lines - preserve the original log event
      _wrapped.output(OutputEvent(event.origin, filteredLines));
    }
  }

  @override
  Future<void> destroy() async {
    await _wrapped.destroy();
  }
}

/// Check if simple logger mode is enabled via environment variable
///
/// Usage: flutter run --dart-define=SIMPLE_LOGGER=true
/// This removes decorative borders from logs, making them easier to copy for AI agents
bool get _isSimpleLoggerMode {
  const simpleMode = String.fromEnvironment(
    'SIMPLE_LOGGER',
    defaultValue: 'false',
  );
  return simpleMode.toLowerCase() == 'true';
}

/// Centralized logger for the application
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, // Disable stack traces for normal logs (cleaner output)
      errorMethodCount: 8, // Keep stack traces for errors
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
    output: _isSimpleLoggerMode
        ? ISpectLogOutput(fallback: BorderlessLogOutput(ConsoleOutput()))
        : ISpectLogOutput(fallback: ConsoleOutput()),
  );

  /// Map to store settings for each category
  static final Map<LogCategory, LogCategorySettings> _categorySettings = {
    for (var category in LogCategory.values)
      category: const LogCategorySettings(),
  };

  /// Load log category settings from storage at startup
  /// This should be called BEFORE any logging happens (in bootstrap before AppInitializer)
  static Future<void> loadSettingsFromStorage() async {
    try {
      final directory = await _getDocumentsDirectory();
      final filePath = '$directory/debug_panel_settings.json';
      final file = File(filePath);

      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final json = jsonDecode(jsonString) as Map<String, dynamic>;

        // Load master logs enabled
        final masterLogsEnabled = json['masterLogsEnabled'] as bool? ?? true;

        // Load category settings first to check if all are disabled
        final logCategorySettingsJson =
            json['logCategorySettings'] as Map<String, dynamic>?;

        bool allCategoriesDisabled = false;

        if (logCategorySettingsJson != null) {
          allCategoriesDisabled = true; // Assume true, then check
          for (final entry in logCategorySettingsJson.entries) {
            try {
              final category = LogCategory.values.firstWhere(
                (e) => e.name == entry.key,
                orElse: () => LogCategory.general,
              );
              final settings = LogCategorySettings.fromJson(
                entry.value as Map<String, dynamic>,
              );
              _categorySettings[category] = settings;

              // Check if any category is enabled
              if (settings.enabled) {
                allCategoriesDisabled = false;
              }
            } catch (_) {
              // Skip invalid entries
            }
          }
        }

        // Set global logger level:
        // - OFF if masterLogsEnabled is false OR all categories are disabled
        // - ALL otherwise
        if (!masterLogsEnabled || allCategoriesDisabled) {
          Logger.level = Level.off;
        } else {
          Logger.level = Level.all;
        }
      }
    } catch (_) {
      // If loading fails, keep defaults (all enabled)
    }
  }

  static Future<String> _getDocumentsDirectory() async {
    // Use path_provider equivalent logic
    if (Platform.isWindows) {
      return '${Platform.environment['USERPROFILE']}\\OneDrive\\Documents';
    } else if (Platform.isMacOS) {
      return '${Platform.environment['HOME']}/Documents';
    } else if (Platform.isLinux) {
      return '${Platform.environment['HOME']}/Documents';
    } else {
      // Mobile - use a simple path
      return '.';
    }
  }

  /// Update settings for a specific category
  static void setCategorySettings(
    LogCategory category,
    LogCategorySettings settings,
  ) {
    _categorySettings[category] = settings;
  }

  /// Internal helper to process message based on category settings
  static dynamic _processMessage(dynamic message, LogCategory category) {
    // Early bailout if global logging is disabled
    if (Logger.level == Level.off) return null;

    final settings = _categorySettings[category] ?? const LogCategorySettings();

    // If disabled, return null (caller should check this)
    if (!settings.enabled) return null;

    // Only truncate if truncateEnabled is true for this category
    if (settings.truncateEnabled &&
        message is String &&
        message.length > settings.maxLength) {
      return '${message.substring(0, settings.maxLength)}... (truncated ${message.length - settings.maxLength} chars)';
    }

    return message;
  }

  // --- Core Methods (Positional Args for Backward Compatibility) ---

  /// Log debug message
  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    final processed = _processMessage(message, LogCategory.general);
    if (processed != null) {
      _logger.d(processed, error: error, stackTrace: stackTrace);
    }
  }

  /// Log info message
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    final processed = _processMessage(message, LogCategory.general);
    if (processed != null) {
      _logger.i(processed, error: error, stackTrace: stackTrace);
    }
  }

  /// Log warning message
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    final processed = _processMessage(message, LogCategory.general);
    if (processed != null) {
      _logger.w(processed, error: error, stackTrace: stackTrace);
    }
  }

  /// Log error message
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    final processed = _processMessage(message, LogCategory.general);
    if (processed != null) {
      if (error is StackTrace) {
        _logger.e(processed, stackTrace: error);
      } else {
        _logger.e(processed, error: error, stackTrace: stackTrace);
      }
    }
  }

  /// Log fatal message
  static void f(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    final processed = _processMessage(message, LogCategory.general);
    if (processed != null) {
      if (error is StackTrace) {
        _logger.f(processed, stackTrace: error);
      } else {
        _logger.f(processed, error: error, stackTrace: stackTrace);
      }
    }
  }

  // --- Categorized Methods (dc, ic, wc, ec, fc) ---

  /// Log debug message with category
  static void dc(
    LogCategory category,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    final processed = _processMessage(message, category);
    if (processed != null) {
      _logger.d(processed, error: error, stackTrace: stackTrace);
    }
  }

  /// Log info message with category
  static void ic(
    LogCategory category,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    final processed = _processMessage(message, category);
    if (processed != null) {
      _logger.i(processed, error: error, stackTrace: stackTrace);
    }
  }

  /// Log warning message with category
  static void wc(
    LogCategory category,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    final processed = _processMessage(message, category);
    if (processed != null) {
      _logger.w(processed, error: error, stackTrace: stackTrace);
    }
  }

  /// Log error message with category
  static void ec(
    LogCategory category,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    final processed = _processMessage(message, category);
    if (processed != null) {
      if (error is StackTrace) {
        _logger.e(processed, stackTrace: error);
      } else {
        _logger.e(processed, error: error, stackTrace: stackTrace);
      }
    }
  }

  /// Log fatal message with category
  static void fc(
    LogCategory category,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    final processed = _processMessage(message, category);
    if (processed != null) {
      if (error is StackTrace) {
        _logger.f(processed, stackTrace: error);
      } else {
        _logger.f(processed, error: error, stackTrace: stackTrace);
      }
    }
  }
}
