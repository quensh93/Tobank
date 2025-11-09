import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Debug panel state management
class DebugPanelState {
  const DebugPanelState({
    this.isVisible = false,
    this.selectedTab = 0,
    this.isEnabled = false,
    this.breakpoint = DebugPanelBreakpoint.desktop,
    this.orientation = DebugPanelOrientation.portrait,
    this.settings = const {},
  });

  final bool isVisible;
  final int selectedTab;
  final bool isEnabled;
  final DebugPanelBreakpoint breakpoint;
  final DebugPanelOrientation orientation;
  final Map<String, dynamic> settings;

  DebugPanelState copyWith({
    bool? isVisible,
    int? selectedTab,
    bool? isEnabled,
    DebugPanelBreakpoint? breakpoint,
    DebugPanelOrientation? orientation,
    Map<String, dynamic>? settings,
  }) {
    return DebugPanelState(
      isVisible: isVisible ?? this.isVisible,
      selectedTab: selectedTab ?? this.selectedTab,
      isEnabled: isEnabled ?? this.isEnabled,
      breakpoint: breakpoint ?? this.breakpoint,
      orientation: orientation ?? this.orientation,
      settings: settings ?? this.settings,
    );
  }
}

/// Debug panel breakpoints
enum DebugPanelBreakpoint {
  mobile,
  tablet,
  desktop,
}

/// Debug panel orientation
enum DebugPanelOrientation {
  portrait,
  landscape,
}

/// Debug panel settings
class DebugPanelSettings {
  const DebugPanelSettings({
    this.showAppFrame = true,
    this.showToolPanel = true,
    this.panelWidth = 400.0,
    this.mobilePanelHeight = 300.0,
    this.enableScreenshots = true,
    this.enableLogs = true,
    this.enableAccessibility = true,
    this.enablePerformance = true,
    this.enableNetwork = true,
  });

  final bool showAppFrame;
  final bool showToolPanel;
  final double panelWidth;
  final double mobilePanelHeight;
  final bool enableScreenshots;
  final bool enableLogs;
  final bool enableAccessibility;
  final bool enablePerformance;
  final bool enableNetwork;

  Map<String, dynamic> toJson() => {
        'showAppFrame': showAppFrame,
        'showToolPanel': showToolPanel,
        'panelWidth': panelWidth,
        'mobilePanelHeight': mobilePanelHeight,
        'enableScreenshots': enableScreenshots,
        'enableLogs': enableLogs,
        'enableAccessibility': enableAccessibility,
        'enablePerformance': enablePerformance,
        'enableNetwork': enableNetwork,
      };

  factory DebugPanelSettings.fromJson(Map<String, dynamic> json) {
    return DebugPanelSettings(
      showAppFrame: json['showAppFrame'] ?? true,
      showToolPanel: json['showToolPanel'] ?? true,
      panelWidth: (json['panelWidth'] ?? 400.0).toDouble(),
      mobilePanelHeight: (json['mobilePanelHeight'] ?? 300.0).toDouble(),
      enableScreenshots: json['enableScreenshots'] ?? true,
      enableLogs: json['enableLogs'] ?? true,
      enableAccessibility: json['enableAccessibility'] ?? true,
      enablePerformance: json['enablePerformance'] ?? true,
      enableNetwork: json['enableNetwork'] ?? true,
    );
  }
}

/// Debug panel controller
class DebugPanelController extends Notifier<DebugPanelState> {
  @override
  DebugPanelState build() => const DebugPanelState();

  /// Toggle debug panel visibility
  void toggleVisibility() {
    state = state.copyWith(isVisible: !state.isVisible);
  }

  /// Set debug panel visibility
  void setVisibility(bool visible) {
    state = state.copyWith(isVisible: visible);
  }

  /// Select a tab
  void selectTab(int tabIndex) {
    state = state.copyWith(selectedTab: tabIndex);
  }

  /// Toggle debug panel enabled state
  void toggleEnabled() {
    state = state.copyWith(isEnabled: !state.isEnabled);
  }

  /// Set debug panel enabled state
  void setEnabled(bool enabled) {
    state = state.copyWith(isEnabled: enabled);
  }

  /// Update breakpoint
  void updateBreakpoint(DebugPanelBreakpoint breakpoint) {
    state = state.copyWith(breakpoint: breakpoint);
  }

  /// Update orientation
  void updateOrientation(DebugPanelOrientation orientation) {
    state = state.copyWith(orientation: orientation);
  }

  /// Update settings
  void updateSettings(Map<String, dynamic> settings) {
    state = state.copyWith(settings: settings);
  }

  /// Get a specific setting value
  T? getSetting<T>(String key) {
    return state.settings[key] as T?;
  }

  /// Set a specific setting value
  void setSetting<T>(String key, T value) {
    final newSettings = Map<String, dynamic>.from(state.settings);
    newSettings[key] = value;
    state = state.copyWith(settings: newSettings);
  }
}

/// Debug panel provider
final debugPanelProvider = NotifierProvider<DebugPanelController, DebugPanelState>(
  () => DebugPanelController(),
);

/// Debug panel settings provider
final debugPanelSettingsProvider = Provider<DebugPanelSettings>((ref) {
  final state = ref.watch(debugPanelProvider);
  return DebugPanelSettings.fromJson(state.settings);
});

/// Debug panel visibility provider
final debugPanelVisibilityProvider = Provider<bool>((ref) {
  return ref.watch(debugPanelProvider).isVisible;
});

/// Debug panel enabled provider
final debugPanelEnabledProvider = Provider<bool>((ref) {
  return ref.watch(debugPanelProvider).isEnabled;
});

/// Debug panel selected tab provider
final debugPanelSelectedTabProvider = Provider<int>((ref) {
  return ref.watch(debugPanelProvider).selectedTab;
});

/// Debug panel breakpoint provider
final debugPanelBreakpointProvider = Provider<DebugPanelBreakpoint>((ref) {
  return ref.watch(debugPanelProvider).breakpoint;
});

/// Debug panel orientation provider
final debugPanelOrientationProvider = Provider<DebugPanelOrientation>((ref) {
  return ref.watch(debugPanelProvider).orientation;
});

/// Debug panel utilities
class DebugPanelUtils {
  /// Get breakpoint from screen width
  static DebugPanelBreakpoint getBreakpoint(double width) {
    if (width < 600) {
      return DebugPanelBreakpoint.mobile;
    } else if (width < 900) {
      return DebugPanelBreakpoint.tablet;
    } else {
      return DebugPanelBreakpoint.desktop;
    }
  }

  /// Get orientation from screen dimensions
  static DebugPanelOrientation getOrientation(Size size) {
    return size.width > size.height
        ? DebugPanelOrientation.landscape
        : DebugPanelOrientation.portrait;
  }

  /// Check if screen is small
  static bool isSmallScreen(double width) {
    return width < 700;
  }

  /// Check if screen is mobile
  static bool isMobileScreen(double width) {
    return width < 600;
  }

  /// Check if screen is tablet
  static bool isTabletScreen(double width) {
    return width >= 600 && width < 900;
  }

  /// Check if screen is desktop
  static bool isDesktopScreen(double width) {
    return width >= 900;
  }
}

/// Debug panel extensions
extension DebugPanelStateExtensions on DebugPanelState {
  /// Check if debug panel is active
  bool get isActive => isVisible && isEnabled;

  /// Get current tab name
  String get currentTabName {
    switch (selectedTab) {
      case 0:
        return 'Logs';
      case 1:
        return 'Tools';
      case 2:
        return 'Accessibility';
      case 3:
        return 'Performance';
      case 4:
        return 'Network';
      default:
        return 'Unknown';
    }
  }

  /// Get current tab icon
  IconData get currentTabIcon {
    switch (selectedTab) {
      case 0:
        return Icons.bug_report;
      case 1:
        return Icons.build;
      case 2:
        return Icons.accessibility;
      case 3:
        return Icons.speed;
      case 4:
        return Icons.network_check;
      default:
        return Icons.help;
    }
  }
}