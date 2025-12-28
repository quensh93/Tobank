// Debug Panel Settings State and Controller
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:logger/logger.dart';
import 'package:universal_io/io.dart' as io;
import 'dart:convert';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:shared_preferences/shared_preferences.dart'; // For Web persistence

import '../../core/helpers/logger.dart';
import '../themes/debug_panel_theme.dart';

/// UI Size options for debug panel
enum DebugPanelUISize {
  small,
  medium,
  large;

  double get scaleFactor {
    switch (this) {
      case DebugPanelUISize.small:
        return 0.85;
      case DebugPanelUISize.medium:
        return 1.0;
      case DebugPanelUISize.large:
        return 1.15;
    }
  }

  double get buttonHeight {
    switch (this) {
      case DebugPanelUISize.small:
        return 36.0;
      case DebugPanelUISize.medium:
        return 40.0;
      case DebugPanelUISize.large:
        return 48.0;
    }
  }

  double get iconSize {
    switch (this) {
      case DebugPanelUISize.small:
        return 18.0;
      case DebugPanelUISize.medium:
        return 24.0;
      case DebugPanelUISize.large:
        return 28.0;
    }
  }
}

/// Layout mode for debug panel
enum DebugPanelLayoutMode {
  horizontal, // Left-right (current)
  vertical; // Top-bottom

  String get displayName {
    switch (this) {
      case DebugPanelLayoutMode.horizontal:
        return 'Left-Right';
      case DebugPanelLayoutMode.vertical:
        return 'Top-Bottom';
    }
  }
}

/// Layout mode for performance tab
enum PerformanceLayoutMode {
  grid, // All charts in grid (responsive)
  singleRow; // All charts in single row

  String get displayName {
    switch (this) {
      case PerformanceLayoutMode.grid:
        return 'Grid Layout';
      case PerformanceLayoutMode.singleRow:
        return 'Single Row';
    }
  }
}

/// Debug panel settings state
class DebugPanelSettingsState {
  const DebugPanelSettingsState({
    // Main panel control
    this.debugPanelEnabled = true,
    this.ispectDraggablePanelEnabled = true,
    this.textScaleFactor = 1.0,
    this.uiSize = DebugPanelUISize.medium,
    this.layoutMode = DebugPanelLayoutMode.horizontal,
    this.leftPanelWidth = 0.6,
    this.topPanelHeight = 0.6,
    this.themeMode = DebugPanelThemeMode.system,
    // Supabase configuration
    this.supabaseEnabled = false,
    // Device preview settings
    this.deviceId = '',
    this.isFrameVisible = true,
    this.isPreviewEnabled = true,
    this.deviceOrientation = Orientation.portrait,
    // Logs settings
    this.masterLogsEnabled = true,
    this.logsAutoScroll = true,
    this.logsSelectedLevel,
    this.logMaxLength = 1000,
    this.logTruncationEnabled = false,
    // Accessibility settings
    this.accessibilitySelectedFilter,
    // Performance settings
    this.performanceTrackingEnabled = true,
    this.performanceLayoutMode = PerformanceLayoutMode.grid,
    this.performanceSampleSize = 32,
    // Tab selection
    this.selectedTabIndex = 0,
    this.logCategorySettings = const {},
  });

  // Fields
  final bool debugPanelEnabled;
  final bool ispectDraggablePanelEnabled;
  final double textScaleFactor;
  final DebugPanelUISize uiSize;
  final DebugPanelLayoutMode layoutMode;
  final double leftPanelWidth;
  final double topPanelHeight;
  final DebugPanelThemeMode themeMode;
  // Supabase configuration
  final bool supabaseEnabled;
  // Device preview settings
  final String deviceId;
  final bool isFrameVisible;
  final bool isPreviewEnabled;
  final Orientation deviceOrientation;
  // Logs settings
  final bool masterLogsEnabled;
  final bool logsAutoScroll;
  final String? logsSelectedLevel;
  final int logMaxLength;
  final bool logTruncationEnabled;
  // Accessibility settings
  final String? accessibilitySelectedFilter;
  // Performance settings
  final bool performanceTrackingEnabled;
  final PerformanceLayoutMode performanceLayoutMode;
  final int performanceSampleSize;
  // Tab selection
  final int selectedTabIndex;
  final Map<LogCategory, LogCategorySettings> logCategorySettings;

  DebugPanelSettingsState copyWith({
    bool? debugPanelEnabled,
    bool? ispectDraggablePanelEnabled,
    double? textScaleFactor,
    DebugPanelUISize? uiSize,
    DebugPanelLayoutMode? layoutMode,
    double? leftPanelWidth,
    double? topPanelHeight,
    DebugPanelThemeMode? themeMode,
    String? deviceId,
    bool? isFrameVisible,
    bool? isPreviewEnabled,
    Orientation? deviceOrientation,
    bool? masterLogsEnabled,
    bool? logsAutoScroll,
    String? logsSelectedLevel,
    int? logMaxLength,
    bool? logTruncationEnabled,
    String? accessibilitySelectedFilter,
    bool? performanceTrackingEnabled,
    PerformanceLayoutMode? performanceLayoutMode,
    int? performanceSampleSize,
    int? selectedTabIndex,
    bool? supabaseEnabled,
    Map<LogCategory, LogCategorySettings>? logCategorySettings,
  }) {
    return DebugPanelSettingsState(
      debugPanelEnabled: debugPanelEnabled ?? this.debugPanelEnabled,
      ispectDraggablePanelEnabled:
          ispectDraggablePanelEnabled ?? this.ispectDraggablePanelEnabled,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      uiSize: uiSize ?? this.uiSize,
      layoutMode: layoutMode ?? this.layoutMode,
      leftPanelWidth: leftPanelWidth ?? this.leftPanelWidth,
      topPanelHeight: topPanelHeight ?? this.topPanelHeight,
      themeMode: themeMode ?? this.themeMode,
      deviceId: deviceId ?? this.deviceId,
      isFrameVisible: isFrameVisible ?? this.isFrameVisible,
      isPreviewEnabled: isPreviewEnabled ?? this.isPreviewEnabled,
      deviceOrientation: deviceOrientation ?? this.deviceOrientation,
      masterLogsEnabled: masterLogsEnabled ?? this.masterLogsEnabled,
      logsAutoScroll: logsAutoScroll ?? this.logsAutoScroll,
      logsSelectedLevel: logsSelectedLevel ?? this.logsSelectedLevel,
      logMaxLength: logMaxLength ?? this.logMaxLength,
      logTruncationEnabled: logTruncationEnabled ?? this.logTruncationEnabled,
      accessibilitySelectedFilter:
          accessibilitySelectedFilter ?? this.accessibilitySelectedFilter,
      performanceTrackingEnabled:
          performanceTrackingEnabled ?? this.performanceTrackingEnabled,
      performanceLayoutMode:
          performanceLayoutMode ?? this.performanceLayoutMode,
      performanceSampleSize:
          performanceSampleSize ?? this.performanceSampleSize,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      supabaseEnabled: supabaseEnabled ?? this.supabaseEnabled,
      logCategorySettings: logCategorySettings ?? this.logCategorySettings,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'debugPanelEnabled': debugPanelEnabled,
      'ispectDraggablePanelEnabled': ispectDraggablePanelEnabled,
      'textScaleFactor': textScaleFactor,
      'uiSize': uiSize.name,
      'layoutMode': layoutMode.name,
      'leftPanelWidth': leftPanelWidth,
      'topPanelHeight': topPanelHeight,
      'themeMode': themeMode.name,
      'deviceId': deviceId,
      'isFrameVisible': isFrameVisible,
      'isPreviewEnabled': isPreviewEnabled,
      'deviceOrientation': deviceOrientation.name,
      'masterLogsEnabled': masterLogsEnabled,
      'logsAutoScroll': logsAutoScroll,
      'logsSelectedLevel': logsSelectedLevel,
      'logMaxLength': logMaxLength,
      'logTruncationEnabled': logTruncationEnabled,
      'accessibilitySelectedFilter': accessibilitySelectedFilter,
      'performanceTrackingEnabled': performanceTrackingEnabled,
      'performanceLayoutMode': performanceLayoutMode.name,
      'performanceSampleSize': performanceSampleSize,
      'selectedTabIndex': selectedTabIndex,
      'logCategorySettings': logCategorySettings
          .map((key, value) => MapEntry(key.name, value.toJson())),
    };
  }

  factory DebugPanelSettingsState.fromJson(Map<String, dynamic> json) {
    return DebugPanelSettingsState(
      debugPanelEnabled: json['debugPanelEnabled'] as bool? ?? true,
      ispectDraggablePanelEnabled:
          json['ispectDraggablePanelEnabled'] as bool? ?? true,
      textScaleFactor: (json['textScaleFactor'] as num?)?.toDouble() ?? 1.0,
      uiSize: DebugPanelUISize.values.firstWhere(
        (e) => e.name == json['uiSize'],
        orElse: () => DebugPanelUISize.medium,
      ),
      layoutMode: DebugPanelLayoutMode.values.firstWhere(
        (e) => e.name == json['layoutMode'],
        orElse: () => DebugPanelLayoutMode.horizontal,
      ),
      leftPanelWidth: (json['leftPanelWidth'] as num?)?.toDouble() ?? 0.6,
      topPanelHeight: (json['topPanelHeight'] as num?)?.toDouble() ?? 0.6,
      themeMode: DebugPanelThemeMode.values.firstWhere(
        (e) => e.name == json['themeMode'],
        orElse: () => DebugPanelThemeMode.system,
      ),
      deviceId: json['deviceId'] as String? ?? '',
      isFrameVisible: json['isFrameVisible'] as bool? ?? true,
      isPreviewEnabled: json['isPreviewEnabled'] as bool? ?? true,
      deviceOrientation: json['deviceOrientation'] == 'landscape'
          ? Orientation.landscape
          : Orientation.portrait,
      masterLogsEnabled: json['masterLogsEnabled'] as bool? ?? true,
      logsAutoScroll: json['logsAutoScroll'] as bool? ?? true,
      logsSelectedLevel: json['logsSelectedLevel'] as String?,
      logMaxLength: (json['logMaxLength'] as num?)?.toInt() ?? 1000,
      logTruncationEnabled: json['logTruncationEnabled'] as bool? ?? false,
      accessibilitySelectedFilter:
          json['accessibilitySelectedFilter'] as String?,
      performanceTrackingEnabled:
          json['performanceTrackingEnabled'] as bool? ?? true,
      performanceLayoutMode: PerformanceLayoutMode.values.firstWhere(
        (e) => e.name == json['performanceLayoutMode'],
        orElse: () => PerformanceLayoutMode.grid,
      ),
      performanceSampleSize:
          (json['performanceSampleSize'] as num?)?.toInt() ?? 32,
      selectedTabIndex: (json['selectedTabIndex'] as num?)?.toInt() ?? 0,
      supabaseEnabled: json['supabaseEnabled'] as bool? ?? false,
      logCategorySettings:
          (json['logCategorySettings'] as Map<String, dynamic>?)?.map(
                (key, value) => MapEntry(
                  LogCategory.values.firstWhere(
                    (e) => e.name == key,
                    orElse: () => LogCategory.general,
                  ),
                  LogCategorySettings.fromJson(value),
                ),
              ) ??
              {},
    );
  }
}

/// Debug panel settings controller
class DebugPanelSettingsController extends Notifier<DebugPanelSettingsState> {
  static const String _storageFileName = 'debug_panel_settings.json';
  bool _isLoading = false;

  @override
  DebugPanelSettingsState build() {
    _loadSettingsImmediate();
    return const DebugPanelSettingsState();
  }

  void _loadSettingsImmediate() {
    _isLoading = true;
    _loadSettings().then((_) {
      _isLoading = false;
      AppLogger.d('✅ Settings loading completed');
    }).catchError((e) {
      _isLoading = false;
      AppLogger.e('❌ Settings loading failed: $e');
    });
  }

  Future<io.File> _getStorageFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = io.File('${directory.path}/$_storageFileName');
      AppLogger.d('📁 Storage file path: ${file.path}');
      return file;
    } catch (e) {
      AppLogger.e(
          '❌ Failed to get storage directory: $e, using current directory');
      return io.File(_storageFileName);
    }
  }

  Future<void> _loadSettings() async {
    try {
      Map<String, dynamic> data;
      if (kIsWeb) {
        final prefs = await SharedPreferences.getInstance();
        final jsonString = prefs.getString(_storageFileName);
        if (jsonString != null) {
          data = jsonDecode(jsonString) as Map<String, dynamic>;
          AppLogger.d('📂 Loaded settings from SharedPreferences');
        } else {
          data = {}; // Will trigger default flow
        }
      } else {
        final file = await _getStorageFile();
        AppLogger.d('📂 Attempting to load settings from: ${file.path}');
        if (await file.exists()) {
          final contents = await file.readAsString();
          data = jsonDecode(contents) as Map<String, dynamic>;
        } else {
          data = {}; // Will trigger default flow
        }
      }

      if (data.isNotEmpty) {
        final settings = DebugPanelSettingsState.fromJson(data);
        state = settings;
        // Sync LogCategory settings
        settings.logCategorySettings.forEach((category, categorySettings) {
          AppLogger.setCategorySettings(category, categorySettings);
        });
        AppLogger.d('✅ Debug panel settings loaded successfully');
      } else {
        AppLogger.d('📂 No saved debug panel settings found, using defaults');
        const defaults = DebugPanelSettingsState();
        if (defaults.deviceId.isEmpty) {
          // On Web, default is just loaded. On Mobile, we might want to save defaults.
          // But postponing save is better.
          // For now, let's just save defaults if not web? Or both.
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            // Save defaults
            final dataJson = defaults.toJson();
            dataJson['deviceId'] = 'iphone-15-pro';

            if (kIsWeb) {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString(_storageFileName, jsonEncode(dataJson));
            } else {
              final file = await _getStorageFile();
              await file.writeAsString(jsonEncode(dataJson));
            }
          });
        }
      }
    } catch (e, stackTrace) {
      AppLogger.e('❌ Failed to load debug panel settings: $e');
      AppLogger.e('❌ Stack trace: $stackTrace');
    }
  }

  Future<void> _saveSettings() async {
    if (_isLoading) {
      AppLogger.d('⏸️ Skipping save during initial load');
      return;
    }
    try {
      final data = Map<String, dynamic>.from(state.toJson());
      data['savedAt'] = DateTime.now().toIso8601String();
      final jsonString = jsonEncode(data);
      AppLogger.d('💾 Saving settings');

      if (kIsWeb) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_storageFileName, jsonString);
      } else {
        final file = await _getStorageFile();
        await file.writeAsString(jsonString);
      }
    } catch (e, stackTrace) {
      AppLogger.e('❌ Failed to save debug panel settings: $e');
      AppLogger.e('❌ Stack trace: $stackTrace');
    }
  }

  // Setter methods
  void setDebugPanelEnabled(bool enabled) {
    state = state.copyWith(debugPanelEnabled: enabled);
    _saveSettings();
  }

  void setIspectDraggablePanelEnabled(bool enabled) {
    state = state.copyWith(ispectDraggablePanelEnabled: enabled);
    _saveSettings();
  }

  void setTextScaleFactor(double factor) {
    final clamped = factor.clamp(0.8, 2.0);
    state = state.copyWith(textScaleFactor: clamped);
    _saveSettings();
  }

  void setUISize(DebugPanelUISize size) {
    state = state.copyWith(uiSize: size);
    _saveSettings();
  }

  void setLayoutMode(DebugPanelLayoutMode mode) {
    state = state.copyWith(layoutMode: mode);
    _saveSettings();
  }

  void setLeftPanelWidth(double width) {
    final clamped = width.clamp(0.2, 0.8);
    state = state.copyWith(leftPanelWidth: clamped);
    _saveSettings();
  }

  void setTopPanelHeight(double height) {
    final clamped = height.clamp(0.2, 0.8);
    state = state.copyWith(topPanelHeight: clamped);
    _saveSettings();
  }

  void setDeviceId(String deviceId) {
    state = state.copyWith(deviceId: deviceId);
    _saveSettings();
  }

  void setFrameVisible(bool visible) {
    state = state.copyWith(isFrameVisible: visible);
    _saveSettings();
  }

  void setPreviewEnabled(bool enabled) {
    state = state.copyWith(isPreviewEnabled: enabled);
    _saveSettings();
  }

  void setDeviceOrientation(Orientation orientation) {
    state = state.copyWith(deviceOrientation: orientation);
    _saveSettings();
  }

  void setLogsAutoScroll(bool autoScroll) {
    state = state.copyWith(logsAutoScroll: autoScroll);
    _saveSettings();
  }

  void setLogsSelectedLevel(String? level) {
    state = state.copyWith(logsSelectedLevel: level);
    _saveSettings();
  }

  void setLogMaxLength(int length) {
    state = state.copyWith(logMaxLength: length);
    // Logger.maxLogLength = length; // Removed
    _saveSettings();
  }

  void setLogTruncationEnabled(bool enabled) {
    state = state.copyWith(logTruncationEnabled: enabled);
    // Logger.truncateLogs = enabled; // Removed
    _saveSettings();
  }

  void setAccessibilitySelectedFilter(String? filter) {
    state = state.copyWith(accessibilitySelectedFilter: filter);
    _saveSettings();
  }

  void setThemeMode(DebugPanelThemeMode mode) {
    state = state.copyWith(themeMode: mode);
    _saveSettings();
  }

  void setSelectedTabIndex(int index) {
    state = state.copyWith(selectedTabIndex: index);
    _saveSettings();
  }

  // Supabase setters (optional, not used directly in UI yet)
  void setSupabaseEnabled(bool enabled) {
    state = state.copyWith(supabaseEnabled: enabled);
    _saveSettings();
  }

  void setPerformanceTrackingEnabled(bool enabled) {
    state = state.copyWith(performanceTrackingEnabled: enabled);
    _saveSettings();
  }

  void setPerformanceLayoutMode(PerformanceLayoutMode mode) {
    state = state.copyWith(performanceLayoutMode: mode);
    _saveSettings();
  }

  void setPerformanceSampleSize(int size) {
    state = state.copyWith(performanceSampleSize: size);
    _saveSettings();
  }

  void setLogCategorySettings(
      LogCategory category, LogCategorySettings settings) {
    var newSettings =
        Map<LogCategory, LogCategorySettings>.from(state.logCategorySettings);
    newSettings[category] = settings;
    state = state.copyWith(logCategorySettings: newSettings);
    // Sync to Logger immediately
    AppLogger.setCategorySettings(category, settings);

    // If updating General category, sync to global Logger for stac_logger and others
    // If updating General category, sync to global Logger for stac_logger and others
    if (category == LogCategory.general) {
      // Logger properties removed as they don't exist
    }

    // Check if all categories are now disabled
    final allDisabled = newSettings.values.every((s) => !s.enabled);
    if (allDisabled) {
      Logger.level = Level.off;
    } else if (state.masterLogsEnabled) {
      Logger.level = Level.all;
    }

    _saveSettings();
  }

  void setMasterLogsEnabled(bool enabled) {
    // Set global logger level to control ALL logging (including stac_logger)
    Logger.level = enabled ? Level.all : Level.off;

    state = state.copyWith(masterLogsEnabled: enabled);
    // When master is toggled, update all categories
    var newSettings =
        Map<LogCategory, LogCategorySettings>.from(state.logCategorySettings);
    for (final category in LogCategory.values) {
      final current = newSettings[category] ?? const LogCategorySettings();
      newSettings[category] = current.copyWith(enabled: enabled);
      AppLogger.setCategorySettings(category, newSettings[category]!);
    }
    state = state.copyWith(logCategorySettings: newSettings);
    _saveSettings();
  }

  /// Enable all log categories AND restore Logger.level to allow stac_logger
  void enableAllCategories() {
    // Restore Logger.level so stac_logger can log
    if (state.masterLogsEnabled) {
      Logger.level = Level.all;
    }

    var newSettings =
        Map<LogCategory, LogCategorySettings>.from(state.logCategorySettings);
    for (final category in LogCategory.values) {
      final current = newSettings[category] ?? const LogCategorySettings();
      newSettings[category] = current.copyWith(enabled: true);
      AppLogger.setCategorySettings(category, newSettings[category]!);
    }
    state = state.copyWith(logCategorySettings: newSettings);
    _saveSettings();
  }

  /// Disable all log categories AND set Logger.level to off to suppress stac_logger
  void disableAllCategories() {
    // Set Logger.level to off so stac_logger is also suppressed
    Logger.level = Level.off;

    var newSettings =
        Map<LogCategory, LogCategorySettings>.from(state.logCategorySettings);
    for (final category in LogCategory.values) {
      final current = newSettings[category] ?? const LogCategorySettings();
      newSettings[category] = current.copyWith(enabled: false);
      AppLogger.setCategorySettings(category, newSettings[category]!);
    }
    state = state.copyWith(logCategorySettings: newSettings);
    _saveSettings();
  }

  void resetLogSettings() {
    // Restore global logger level
    Logger.level = Level.all;

    // Reset master toggle
    state = state.copyWith(
      masterLogsEnabled: true,
      logTruncationEnabled: false,
      logMaxLength: 1000,
    );
    // Logger.truncateLogs = false; // Removed
    // Logger.maxLogLength = 1000; // Removed
    // Reset all category settings to defaults
    final defaultSettings = <LogCategory, LogCategorySettings>{};
    for (final category in LogCategory.values) {
      const defaultCategorySettings = LogCategorySettings(
        enabled: true,
        truncateEnabled: false,
        maxLength: 1000,
      );
      defaultSettings[category] = defaultCategorySettings;
      AppLogger.setCategorySettings(category, defaultCategorySettings);
    }
    state = state.copyWith(logCategorySettings: defaultSettings);
    _saveSettings();
    AppLogger.i('🔧 Log settings reset to defaults');
  }
}

// Provider for the settings controller
final debugPanelSettingsProvider =
    NotifierProvider<DebugPanelSettingsController, DebugPanelSettingsState>(
  DebugPanelSettingsController.new,
);
