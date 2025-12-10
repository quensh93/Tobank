// Debug Panel Settings State and Controller
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
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
    this.logsAutoScroll = true,
    this.logsSelectedLevel,
    // Accessibility settings
    this.accessibilitySelectedFilter,
    // Performance settings
    this.performanceTrackingEnabled = true,
    this.performanceLayoutMode = PerformanceLayoutMode.grid,
    this.performanceSampleSize = 32,
    // Tab selection
    this.selectedTabIndex = 0,
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
  final bool logsAutoScroll;
  final String? logsSelectedLevel;
  // Accessibility settings
  final String? accessibilitySelectedFilter;
  // Performance settings
  final bool performanceTrackingEnabled;
  final PerformanceLayoutMode performanceLayoutMode;
  final int performanceSampleSize;
  // Tab selection
  final int selectedTabIndex;

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
    bool? logsAutoScroll,
    String? logsSelectedLevel,
    String? accessibilitySelectedFilter,
    bool? performanceTrackingEnabled,
    PerformanceLayoutMode? performanceLayoutMode,
    int? performanceSampleSize,
    int? selectedTabIndex,
    bool? supabaseEnabled,
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
      logsAutoScroll: logsAutoScroll ?? this.logsAutoScroll,
      logsSelectedLevel: logsSelectedLevel ?? this.logsSelectedLevel,
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
      'logsAutoScroll': logsAutoScroll,
      'logsSelectedLevel': logsSelectedLevel,
      'accessibilitySelectedFilter': accessibilitySelectedFilter,
      'performanceTrackingEnabled': performanceTrackingEnabled,
      'performanceLayoutMode': performanceLayoutMode.name,
      'performanceSampleSize': performanceSampleSize,
      'selectedTabIndex': selectedTabIndex,
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
      logsAutoScroll: json['logsAutoScroll'] as bool? ?? true,
      logsSelectedLevel: json['logsSelectedLevel'] as String?,
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

  Future<File> _getStorageFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_storageFileName');
      AppLogger.d('📁 Storage file path: ${file.path}');
      return file;
    } catch (e) {
      AppLogger.e(
          '❌ Failed to get storage directory: $e, using current directory');
      return File(_storageFileName);
    }
  }

  Future<void> _loadSettings() async {
    try {
      final file = await _getStorageFile();
      AppLogger.d('📂 Attempting to load settings from: ${file.path}');
      if (await file.exists()) {
        final contents = await file.readAsString();
        final data = jsonDecode(contents) as Map<String, dynamic>;
        final settings = DebugPanelSettingsState.fromJson(data);
        state = settings;
        AppLogger.d('✅ Debug panel settings loaded successfully');
      } else {
        AppLogger.d('📂 No saved debug panel settings found, using defaults');
        const defaults = DebugPanelSettingsState();
        if (defaults.deviceId.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            final file = await _getStorageFile();
            final data = defaults.toJson();
            data['deviceId'] = 'iphone-15-pro';
            final jsonString = jsonEncode(data);
            await file.writeAsString(jsonString);
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
      final file = await _getStorageFile();
      final data = Map<String, dynamic>.from(state.toJson());
      data['savedAt'] = DateTime.now().toIso8601String();
      final jsonString = jsonEncode(data);
      AppLogger.d('💾 Saving settings');
      await file.writeAsString(jsonString);
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
}

// Provider for the settings controller
final debugPanelSettingsProvider =
    NotifierProvider<DebugPanelSettingsController, DebugPanelSettingsState>(
  DebugPanelSettingsController.new,
);
