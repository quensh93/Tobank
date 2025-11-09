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
  vertical;   // Top-bottom

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
  grid,      // All charts in grid (responsive)
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
    this.debugPanelEnabled = true, // Debug panel enabled by default
    this.ispectDraggablePanelEnabled = true, // ISpect draggable panel enabled by default
    this.textScaleFactor = 1.0,
    this.uiSize = DebugPanelUISize.medium,
    this.layoutMode = DebugPanelLayoutMode.horizontal,
    this.leftPanelWidth = 0.6, // 60% of width for horizontal layout
    this.topPanelHeight = 0.6, // 60% of height for vertical layout
    this.themeMode = DebugPanelThemeMode.system, // Theme mode
    // Device preview settings  
    this.deviceId = '', // Device identifier (will be set on first load)
    this.isFrameVisible = true,
    this.isPreviewEnabled = true,
    this.deviceOrientation = Orientation.portrait,
    // Logs settings
    this.logsAutoScroll = true,
    this.logsSelectedLevel, // Can be null
    // Accessibility settings
    this.accessibilitySelectedFilter, // Can be null
    // Performance settings
    this.performanceTrackingEnabled = true, // Performance tracking enabled
    this.performanceLayoutMode = PerformanceLayoutMode.grid, // Performance layout mode
    this.performanceSampleSize = 32, // Number of frames to display in charts
    // Tab selection
    this.selectedTabIndex = 0, // Selected tab index
  });

  final bool debugPanelEnabled; // Whether debug panel is visible
  final bool ispectDraggablePanelEnabled; // Whether ISpect draggable panel is visible
  final double textScaleFactor; // 0.8 to 2.0
  final DebugPanelUISize uiSize;
  final DebugPanelLayoutMode layoutMode;
  final double leftPanelWidth; // 0.2 to 0.8 for horizontal layout divider position
  final double topPanelHeight; // 0.2 to 0.8 for vertical layout divider position
  final DebugPanelThemeMode themeMode; // Theme mode
  // Device preview settings
  final String deviceId; // Device identifier for device preview
  final bool isFrameVisible;
  final bool isPreviewEnabled;
  final Orientation deviceOrientation;
  // Logs settings
  final bool logsAutoScroll;
  final String? logsSelectedLevel; // LogLevel name (e.g., 'debug', 'info', 'warning', 'error')
  // Accessibility settings
  final String? accessibilitySelectedFilter; // AccessibilityIssueType name
  // Performance settings
  final bool performanceTrackingEnabled; // Performance tracking enabled
  final PerformanceLayoutMode performanceLayoutMode; // Performance layout mode
  final int performanceSampleSize; // Number of frames to display in charts
  // Tab selection
  final int selectedTabIndex; // Selected tab index in the debug panel

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
  }) {
    return DebugPanelSettingsState(
      debugPanelEnabled: debugPanelEnabled ?? this.debugPanelEnabled,
      ispectDraggablePanelEnabled: ispectDraggablePanelEnabled ?? this.ispectDraggablePanelEnabled,
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
      logsSelectedLevel: logsSelectedLevel,
      accessibilitySelectedFilter: accessibilitySelectedFilter,
      performanceTrackingEnabled: performanceTrackingEnabled ?? this.performanceTrackingEnabled,
      performanceLayoutMode: performanceLayoutMode ?? this.performanceLayoutMode,
      performanceSampleSize: performanceSampleSize ?? this.performanceSampleSize,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
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
      ispectDraggablePanelEnabled: json['ispectDraggablePanelEnabled'] as bool? ?? true,
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
      accessibilitySelectedFilter: json['accessibilitySelectedFilter'] as String?,
      performanceTrackingEnabled: json['performanceTrackingEnabled'] as bool? ?? true,
      performanceLayoutMode: PerformanceLayoutMode.values.firstWhere(
        (e) => e.name == json['performanceLayoutMode'],
        orElse: () => PerformanceLayoutMode.grid,
      ),
      performanceSampleSize: (json['performanceSampleSize'] as num?)?.toInt() ?? 32,
      selectedTabIndex: (json['selectedTabIndex'] as num?)?.toInt() ?? 0,
    );
  }
}

/// Debug panel settings controller
class DebugPanelSettingsController extends Notifier<DebugPanelSettingsState> {
  static const String _storageFileName = 'debug_panel_settings.json';
  bool _isLoading = false; // Prevent saves during loading

  @override
  DebugPanelSettingsState build() {
    // Load settings immediately and await - this is critical!
    _loadSettingsImmediate();
    return const DebugPanelSettingsState();
  }

  void _loadSettingsImmediate() {
    // Start loading immediately - don't wait, but ensure it happens
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
      // Use application documents directory for persistent storage
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_storageFileName');
      AppLogger.d('📁 Storage file path: ${file.path}');
      return file;
    } catch (e) {
      AppLogger.e('❌ Failed to get storage directory: $e, using current directory');
      // Fallback to current directory
      return File(_storageFileName);
    }
  }

  Future<void> _loadSettings() async {
    try {
      final file = await _getStorageFile();
      AppLogger.d('📂 Attempting to load settings from: ${file.path}');
      
      if (await file.exists()) {
        final contents = await file.readAsString();
        AppLogger.d('📂 File exists, size: ${contents.length} bytes');
        AppLogger.d('📂 File contents: $contents');
        final data = jsonDecode(contents) as Map<String, dynamic>;
        final settings = DebugPanelSettingsState.fromJson(data);
        // Update state - this will trigger a rebuild
        state = settings;
        AppLogger.d('✅ Debug panel settings loaded successfully: ${settings.toJson()}');
      } else {
        AppLogger.d('📂 No saved debug panel settings found at ${file.path}, using defaults');
        // Create file with defaults on first run (but don't save during load to avoid race)
        final defaults = const DebugPanelSettingsState();
        if (defaults.deviceId.isEmpty) {
          // Initialize device ID on first run
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            final file = await _getStorageFile();
            final data = defaults.toJson();
            data['deviceId'] = 'iphone-15-pro';
            data['savedAt'] = DateTime.now().toIso8601String();
            final jsonString = jsonEncode(data);
            final sink = file.openWrite(mode: FileMode.write);
            try {
              sink.write(jsonString);
              await sink.flush();
            } finally {
              await sink.close();
            }
          });
        }
      }
    } catch (e, stackTrace) {
      AppLogger.e('❌ Failed to load debug panel settings: $e');
      AppLogger.e('❌ Stack trace: $stackTrace');
      // Use defaults
    }
  }

  Future<void> _saveSettings() async {
    // Don't save during initial loading
    if (_isLoading) {
      AppLogger.d('⏸️ Skipping save during initial load');
      return;
    }
    
    try {
      final file = await _getStorageFile();
      final data = Map<String, dynamic>.from(state.toJson()); // Create a copy
      data['savedAt'] = DateTime.now().toIso8601String();
      final jsonString = jsonEncode(data);
      
      AppLogger.d('💾 Saving settings - State: ${state.toJson()}');
      AppLogger.d('💾 JSON to save: $jsonString');
      
      // Use IOSink with flush to ensure immediate write to disk
      final sink = file.openWrite(mode: FileMode.write);
      try {
        sink.write(jsonString);
        await sink.flush();
      } finally {
        await sink.close();
      }
      
      // Verify file was written correctly
      if (await file.exists()) {
        final fileSize = await file.length();
        final savedContents = await file.readAsString();
        final savedData = jsonDecode(savedContents) as Map<String, dynamic>;
        AppLogger.d('💾 Debug panel settings saved successfully to: ${file.path}');
        AppLogger.d('💾 File size: $fileSize bytes');
        AppLogger.d('💾 Verified saved data: ${savedData}');
        AppLogger.d('💾 Current state: ${state.toJson()}');
        
        // Verify all values match
        final matches = savedData['debugPanelEnabled'] == state.debugPanelEnabled &&
            savedData['ispectDraggablePanelEnabled'] == state.ispectDraggablePanelEnabled &&
            savedData['textScaleFactor'] == state.textScaleFactor &&
            savedData['uiSize'] == state.uiSize.name &&
            savedData['layoutMode'] == state.layoutMode.name &&
            savedData['leftPanelWidth'] == state.leftPanelWidth &&
            savedData['topPanelHeight'] == state.topPanelHeight &&
            savedData['themeMode'] == state.themeMode.name &&
            savedData['deviceId'] == state.deviceId &&
            savedData['isFrameVisible'] == state.isFrameVisible &&
            savedData['isPreviewEnabled'] == state.isPreviewEnabled &&
            savedData['deviceOrientation'] == state.deviceOrientation.name &&
            savedData['logsAutoScroll'] == state.logsAutoScroll &&
            savedData['logsSelectedLevel'] == state.logsSelectedLevel &&
            savedData['accessibilitySelectedFilter'] == state.accessibilitySelectedFilter &&
            savedData['performanceTrackingEnabled'] == state.performanceTrackingEnabled &&
            savedData['selectedTabIndex'] == state.selectedTabIndex;
            
        if (!matches) {
          AppLogger.e('❌ WARNING: Saved data does not match current state!');
        } else {
          AppLogger.d('✅ All settings verified and saved correctly!');
        }
      } else {
        AppLogger.e('❌ File was not created after save attempt!');
      }
    } catch (e, stackTrace) {
      AppLogger.e('❌ Failed to save debug panel settings: $e');
      AppLogger.e('❌ Stack trace: $stackTrace');
    }
  }

  /// Set debug panel enabled state
  void setDebugPanelEnabled(bool enabled) {
    AppLogger.i('🔧 Setting debug panel enabled: $enabled');
    state = state.copyWith(debugPanelEnabled: enabled);
    AppLogger.i('✅ Debug panel enabled updated to: $enabled');
    _saveSettings();
  }

  /// Set ISpect draggable panel enabled state
  void setIspectDraggablePanelEnabled(bool enabled) {
    AppLogger.i('🔧 Setting ISpect draggable panel enabled: $enabled');
    state = state.copyWith(ispectDraggablePanelEnabled: enabled);
    AppLogger.i('✅ ISpect draggable panel enabled updated to: $enabled');
    _saveSettings();
  }

  /// Set text scale factor
  void setTextScaleFactor(double factor) {
    final clamped = factor.clamp(0.8, 2.0);
    state = state.copyWith(textScaleFactor: clamped);
    _saveSettings();
  }

  /// Set UI size
  void setUISize(DebugPanelUISize size) {
    state = state.copyWith(uiSize: size);
    _saveSettings();
  }

  /// Set layout mode
  void setLayoutMode(DebugPanelLayoutMode mode) {
    AppLogger.i('🔧 Setting layout mode: ${mode.name} (current: ${state.layoutMode.name})');
    final newState = state.copyWith(layoutMode: mode);
    state = newState;
    AppLogger.i('✅ Layout mode updated to: ${state.layoutMode.name}');
    _saveSettings();
  }

  /// Set left panel width (for horizontal layout)
  void setLeftPanelWidth(double width) {
    final clamped = width.clamp(0.2, 0.8);
    state = state.copyWith(leftPanelWidth: clamped);
    _saveSettings();
  }

  /// Set top panel height (for vertical layout)
  void setTopPanelHeight(double height) {
    final clamped = height.clamp(0.2, 0.8);
    state = state.copyWith(topPanelHeight: clamped);
    _saveSettings();
  }

  /// Set device ID (for device preview)
  void setDeviceId(String deviceId) {
    state = state.copyWith(deviceId: deviceId);
    _saveSettings();
  }

  /// Set frame visibility (for device preview)
  void setFrameVisible(bool visible) {
    state = state.copyWith(isFrameVisible: visible);
    _saveSettings();
  }

  /// Set preview enabled (for device preview)
  void setPreviewEnabled(bool enabled) {
    state = state.copyWith(isPreviewEnabled: enabled);
    _saveSettings();
  }

  /// Set device orientation (for device preview)
  void setDeviceOrientation(Orientation orientation) {
    state = state.copyWith(deviceOrientation: orientation);
    _saveSettings();
  }

  /// Set logs auto-scroll
  void setLogsAutoScroll(bool autoScroll) {
    state = state.copyWith(logsAutoScroll: autoScroll);
    _saveSettings();
  }

  /// Set logs selected level
  void setLogsSelectedLevel(String? level) {
    state = state.copyWith(logsSelectedLevel: level);
    _saveSettings();
  }

  /// Set accessibility selected filter
  void setAccessibilitySelectedFilter(String? filter) {
    state = state.copyWith(accessibilitySelectedFilter: filter);
    _saveSettings();
  }

  /// Set theme mode
  void setThemeMode(DebugPanelThemeMode mode) {
    state = state.copyWith(themeMode: mode);
    _saveSettings();
  }

  /// Set selected tab index
  void setSelectedTabIndex(int index) {
    state = state.copyWith(selectedTabIndex: index);
    _saveSettings();
  }

  /// Set performance tracking enabled
  void setPerformanceTrackingEnabled(bool enabled) {
    state = state.copyWith(performanceTrackingEnabled: enabled);
    _saveSettings();
  }

  void setPerformanceLayoutMode(PerformanceLayoutMode mode) {
    state = state.copyWith(performanceLayoutMode: mode);
    _saveSettings();
  }

  void setPerformanceSampleSize(int sampleSize) {
    state = state.copyWith(performanceSampleSize: sampleSize);
    _saveSettings();
  }
}

/// Debug panel settings provider
final debugPanelSettingsProvider =
    NotifierProvider<DebugPanelSettingsController, DebugPanelSettingsState>(
  DebugPanelSettingsController.new,
);

