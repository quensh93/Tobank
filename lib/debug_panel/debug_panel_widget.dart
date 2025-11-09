import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:device_frame/device_frame.dart';
import '../core/helpers/logger.dart';
import '../core/bootstrap/app_root.dart';
import 'state/device_preview_state.dart';
import 'state/debug_panel_settings_state.dart';
import 'themes/debug_panel_theme.dart';
import 'widgets/device_preview_tab.dart';
import 'widgets/logs_tab.dart';
import 'widgets/accessibility_tab.dart';
import 'widgets/performance_tab.dart';
import 'widgets/network_tab.dart';
import 'widgets/settings_tab.dart';
import 'widgets/color_showcase_screen.dart';

/// Main debug panel widget that wraps the application
/// 
/// This widget provides a responsive debug panel with app preview
/// and debug tools, inspired by device_preview but tailored for
/// internal debugging needs.
class DebugPanel extends ConsumerStatefulWidget {
  /// Create a new [DebugPanel]
  const DebugPanel({
    super.key,
    required this.child,
    this.enabled = true,
    this.tools = const [],
  });

  /// The application widget to be debugged
  final Widget child;

  /// Whether the debug panel is enabled
  final bool enabled;

  /// List of debug tools to display
  final List<DebugTool> tools;

  @override
  ConsumerState<DebugPanel> createState() => _DebugPanelState();
}

class _DebugPanelState extends ConsumerState<DebugPanel> {
  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return DebugPanelProvider(
      tools: widget.tools,
      child: _LayoutSelector(
        child: widget.child,
      ),
    );
  }
}

/// Widget that selects the appropriate layout based on settings and constraints
class _LayoutSelector extends ConsumerWidget {
  const _LayoutSelector({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only watch layout-related settings, not all settings
    // This prevents unnecessary rebuilds when only tab index or other non-layout settings change
    final layoutMode = ref.watch(
      debugPanelSettingsProvider.select((state) => state.layoutMode),
    );
    
    AppLogger.d('🔄 _LayoutSelector building - Layout mode: ${layoutMode.name}');
    
    return LayoutBuilder(
      key: ValueKey('layout_builder_${layoutMode.name}'),
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 700;
        
        AppLogger.d('🏗️ Building debug panel layout - Mode: ${layoutMode.name}, isSmall: $isSmall, width: ${constraints.maxWidth}');
        
        // Create widget based on layout mode preference
        Widget layoutWidget;
        String layoutKey;
        
        if (layoutMode == DebugPanelLayoutMode.vertical) {
          layoutWidget = DebugPanelVerticalLayout(
            key: ValueKey('layout_vertical_${layoutMode.name}'),
            child: child,
          );
          layoutKey = 'vertical';
        } else if (isSmall) {
          layoutWidget = DebugPanelSmallLayout(
            key: ValueKey('layout_small_${layoutMode.name}'),
            child: child,
          );
          layoutKey = 'small';
        } else {
          layoutWidget = DebugPanelLargeLayout(
            key: ValueKey('layout_large_${layoutMode.name}'),
            child: child,
          );
          layoutKey = 'large';
        }
        
        AppLogger.d('✅ Returning $layoutKey layout widget');
        return layoutWidget;
      },
    );
  }
}

/// Provider widget that sets up the debug panel context
class DebugPanelProvider extends ConsumerWidget {
  const DebugPanelProvider({
    super.key,
    required this.child,
    required this.tools,
  });

  final Widget child;
  final List<DebugTool> tools;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final panelSettings = ref.watch(debugPanelSettingsProvider);
    final debugPanelTheme = DebugPanelTheme(themeMode: panelSettings.themeMode);
    final systemBrightness = MediaQuery.of(context).platformBrightness;
    
    return Theme(
      data: debugPanelTheme.themeForBrightness(systemBrightness),
      child: Localizations(
        locale: const Locale('en'),
        delegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        child: child,
      ),
    );
  }
}

/// Responsive layout for large screens (desktop/tablet)
class DebugPanelLargeLayout extends ConsumerStatefulWidget {
  const DebugPanelLargeLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<DebugPanelLargeLayout> createState() => _DebugPanelLargeLayoutState();
}

class _DebugPanelLargeLayoutState extends ConsumerState<DebugPanelLargeLayout> {
  static const double _minPanelWidth = 0.2; // Minimum 20% width
  static const double _maxPanelWidth = 0.8; // Maximum 80% width
  static const double _minPanelHeight = 300.0; // Minimum height for both panels
  
  double? _dragPanelWidth; // Local state during dragging, null when not dragging

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(debugPanelSettingsProvider);
    final controller = ref.read(debugPanelSettingsProvider.notifier);
    // Use local drag state if available, otherwise use saved state
    final leftPanelWidth = _dragPanelWidth ?? settings.leftPanelWidth;
    
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;
            final availableHeight = constraints.maxHeight;
            const dividerWidth = 8.0;
            final usableWidth = availableWidth - dividerWidth;
            
            return Row(
              children: [
                // Left panel (device preview) - full size outer border
                Expanded(
                  flex: (leftPanelWidth * 1000).round(), // Convert to flex units
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: _minPanelHeight,
                      maxHeight: availableHeight,
                    ),
                    // Use stable key to preserve app widget and navigation state
                    child: AppFrame(
                      key: const ValueKey('app_frame_large'),
                      child: widget.child,
                    ),
                  ),
                ),
                // Resizable divider
                GestureDetector(
                  onPanStart: (_) {
                    // Initialize drag state with current value
                    _dragPanelWidth = settings.leftPanelWidth;
                  },
                  onPanUpdate: (details) {
                    final currentWidth = _dragPanelWidth ?? settings.leftPanelWidth;
                    final delta = details.delta.dx;
                    final newLeftWidth = (currentWidth * usableWidth + delta) / usableWidth;
                    final clampedWidth = newLeftWidth.clamp(_minPanelWidth, _maxPanelWidth);
                    
                    // Update local state for smooth UI (no save yet)
                    setState(() {
                      _dragPanelWidth = clampedWidth;
                    });
                  },
                  onPanEnd: (_) {
                    // Save only when dragging ends
                    if (_dragPanelWidth != null) {
                      controller.setLeftPanelWidth(_dragPanelWidth!);
                      // Clear drag state
                      setState(() {
                        _dragPanelWidth = null;
                      });
                    }
                  },
                  onPanCancel: () {
                    // Cancel drag state on cancel
                    setState(() {
                      _dragPanelWidth = null;
                    });
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeColumn,
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return MouseRegion(
                          onEnter: (_) => setState(() {}),
                          onExit: (_) => setState(() {}),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            width: dividerWidth,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Container(
                                width: 2,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.4),
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Right panel (debug panel) - full size
                Expanded(
                  flex: ((1 - leftPanelWidth) * 1000).round(), // Convert to flex units
                  child: SizedBox(
                    height: double.infinity, // Full height
                    child: ToolPanel(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Responsive layout for small screens (mobile)
class DebugPanelSmallLayout extends ConsumerWidget {
  const DebugPanelSmallLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Reduced from 16.0 to 8.0
        child: Stack(
          children: [
            // App preview area
            Positioned.fill(
              child: AppFrame(
                key: const ValueKey('app_frame_small'),
                child: child,
              ),
            ),
            // Bottom debug panel
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: DebugPanelConstants.mobilePanelHeight,
              child: ToolPanel(isMobile: true),
            ),
          ],
        ),
      ),
    );
  }
}

/// Vertical layout (top-bottom) for debug panel
class DebugPanelVerticalLayout extends ConsumerStatefulWidget {
  const DebugPanelVerticalLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<DebugPanelVerticalLayout> createState() => _DebugPanelVerticalLayoutState();
}

class _DebugPanelVerticalLayoutState extends ConsumerState<DebugPanelVerticalLayout> {
  static const double _minPanelHeight = 0.2; // Minimum 20% height
  static const double _maxPanelHeight = 0.8; // Maximum 80% height
  static const double _minPanelHeightPx = 200.0; // Minimum 200px height
  
  double? _dragPanelHeight; // Local state during dragging, null when not dragging

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(debugPanelSettingsProvider);
    final controller = ref.read(debugPanelSettingsProvider.notifier);
    // Use local drag state if available, otherwise use saved state
    final topPanelHeight = _dragPanelHeight ?? settings.topPanelHeight;
    
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;
            const dividerHeight = 8.0;
            final usableHeight = availableHeight - dividerHeight;
            
            return Column(
              children: [
                // Top panel (device preview)
                Expanded(
                  flex: (topPanelHeight * 1000).round(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: _minPanelHeightPx,
                      maxHeight: availableHeight,
                    ),
                    // Use stable key to preserve app widget and navigation state
                    child: AppFrame(
                      key: const ValueKey('app_frame_vertical'),
                      child: widget.child,
                    ),
                  ),
                ),
                // Resizable divider
                GestureDetector(
                  onPanStart: (_) {
                    // Initialize drag state with current value
                    _dragPanelHeight = settings.topPanelHeight;
                  },
                  onPanUpdate: (details) {
                    final currentHeight = _dragPanelHeight ?? settings.topPanelHeight;
                    final delta = details.delta.dy;
                    final newTopHeight = (currentHeight * usableHeight + delta) / usableHeight;
                    final clampedHeight = newTopHeight.clamp(_minPanelHeight, _maxPanelHeight);
                    
                    // Update local state for smooth UI (no save yet)
                    setState(() {
                      _dragPanelHeight = clampedHeight;
                    });
                  },
                  onPanEnd: (_) {
                    // Save only when dragging ends
                    if (_dragPanelHeight != null) {
                      controller.setTopPanelHeight(_dragPanelHeight!);
                      // Clear drag state
                      setState(() {
                        _dragPanelHeight = null;
                      });
                    }
                  },
                  onPanCancel: () {
                    // Cancel drag state on cancel
                    setState(() {
                      _dragPanelHeight = null;
                    });
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpDown,
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return MouseRegion(
                          onEnter: (_) => setState(() {}),
                          onExit: (_) => setState(() {}),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            height: dividerHeight,
                            width: double.infinity, // Full width divider
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Container(
                                width: 40,
                                height: 2,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.4),
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Bottom panel (debug panel) - full width
                Expanded(
                  flex: ((1 - topPanelHeight) * 1000).round(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: _minPanelHeightPx,
                      maxHeight: availableHeight,
                    ),
                    child: SizedBox(
                      width: double.infinity, // Explicit full width
                      child: ToolPanel(isVertical: true), // Pass isVertical flag
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// App frame that shows the current app state with device preview
class AppFrame extends ConsumerWidget {
  const AppFrame({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceState = ref.watch(devicePreviewProvider);
    
    // Use a stable key to preserve the widget tree and prevent navigation resets
    return Container(
      key: const ValueKey('app_frame'),
      width: double.infinity, // Outer border full width
      height: double.infinity, // Outer border full height
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.5), // Adjusted to match container
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add padding inside the frame
          child: Center( // Center the device frame
            child: RepaintBoundary(
              // Use stable key to preserve widget identity and prevent navigation resets
              key: const ValueKey('app_frame_content'),
              child: deviceState.isPreviewEnabled
                  ? _buildDevicePreview(context, deviceState)
                  : child,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDevicePreview(BuildContext context, DevicePreviewState state) {
    final device = state.selectedDevice;
    final orientation = state.orientation;
    
    return DeviceFrame(
      device: device,
      screen: child,
      orientation: orientation,
      isFrameVisible: state.isFrameVisible,
    );
  }
}

/// Tool panel containing debug tools
class ToolPanel extends ConsumerStatefulWidget {
  const ToolPanel({
    super.key,
    this.isMobile = false,
    this.isVertical = false, // New parameter for vertical layout
  });

  final bool isMobile;
  final bool isVertical; // Whether in vertical (top-bottom) layout

  @override
  ConsumerState<ToolPanel> createState() => _ToolPanelState();
}

class _ToolPanelState extends ConsumerState<ToolPanel> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isRestoringTab = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    // Only save tab changes if we're not currently restoring a tab
    if (!_isRestoringTab && !_tabController.indexIsChanging) {
      final currentIndex = ref.read(debugPanelSettingsProvider).selectedTabIndex;
      if (_tabController.index != currentIndex) {
        ref.read(debugPanelSettingsProvider.notifier).setSelectedTabIndex(_tabController.index);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(debugPanelSettingsProvider);
    
    // Restore saved tab index when settings change
    if (_tabController.index != settings.selectedTabIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_tabController.index != settings.selectedTabIndex) {
          _isRestoringTab = true;
          _tabController.animateTo(settings.selectedTabIndex);
          // Reset flag after animation completes
          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted) {
              _isRestoringTab = false;
            }
          });
        }
      });
    }
    
    return LayoutBuilder(
        builder: (context, constraints) {
          final width = widget.isVertical ? constraints.maxWidth : null;
          return Container(
            width: width, // Full width in vertical layout
            height: double.infinity, // Full height in all layouts
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: widget.isVertical
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    )
                  : widget.isMobile
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        )
                      : const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: widget.isVertical
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(14.5),
                      topRight: Radius.circular(14.5),
                    )
                  : widget.isMobile
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(14.5),
                          topRight: Radius.circular(14.5),
                        )
                      : const BorderRadius.only(
                          topLeft: Radius.circular(14.5),
                          bottomLeft: Radius.circular(14.5),
                        ),
              child: Material(
                elevation: 0,
                color: Colors.transparent,
                child: MediaQuery(
                  // Apply text scale ONLY to the debug panel, not the device frame
                  data: MediaQuery.of(context).copyWith(
                    textScaler: TextScaler.linear(settings.textScaleFactor),
                  ),
                  child: Column(
                    children: [
                        // Tab bar with proper padding - using UI size settings
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 4.0,
                          ),
                          child: TabBar(
                            controller: _tabController,
                            tabs: [
                                Tab(
                                  icon: Icon(Icons.phone_android, size: settings.uiSize.iconSize),
                                  text: 'Device',
                                ),
                                Tab(
                                  icon: Icon(Icons.bug_report, size: settings.uiSize.iconSize),
                                  text: 'Logs',
                                ),
                                Tab(
                                  icon: Icon(Icons.build, size: settings.uiSize.iconSize),
                                  text: 'Tools',
                                ),
                                Tab(
                                  icon: Icon(Icons.accessibility, size: settings.uiSize.iconSize),
                                  text: 'Accessibility',
                                ),
                                Tab(
                                  icon: Icon(Icons.speed, size: settings.uiSize.iconSize),
                                  text: 'Performance',
                                ),
                                Tab(
                                  icon: Icon(Icons.network_check, size: settings.uiSize.iconSize),
                                  text: 'Network',
                                ),
                                Tab(
                                  icon: Icon(Icons.settings, size: settings.uiSize.iconSize),
                                  text: 'Settings',
                                ),
                              ],
                              isScrollable: true,
                              tabAlignment: widget.isMobile ? TabAlignment.start : TabAlignment.center,
                            ),
                          ),
                        // Tab content - UI size will be applied within each tab
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              DevicePreviewTab(),
                              LogsTab(),
                              ToolsTab(),
                              AccessibilityTab(),
                              PerformanceTab(),
                              NetworkTab(),
                              SettingsTab(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
        }, // End builder function
      ); // End LayoutBuilder
  }
}

/// Debug tool interface
abstract class DebugTool {
  String get name;
  String get description;
  IconData get icon;
  Widget build(BuildContext context);
}

/// Debug panel constants
class DebugPanelConstants {
  static const double panelWidth = 400.0;
  static const double mobilePanelHeight = 200.0; // Further reduced height to prevent overflow
  static const double breakpoint = 700.0;
}

/// Tools tab with various development tools
class ToolsTab extends StatelessWidget {
  const ToolsTab({super.key});
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context, 'Design System Tools', Icons.palette),
          const SizedBox(height: 12),
          _buildToolCard(
            context,
            icon: Icons.color_lens,
            title: 'Color Showcase',
            description: 'View all ColorScheme colors applied to Material widgets in a device frame',
            onTap: () {
              // Navigate the main app (device frame) using the main app's Navigator key
              final navigatorKey = AppRoot.mainAppNavigatorKey;
              final navigator = navigatorKey.currentState;
              if (navigator != null) {
                navigator.push(
                  MaterialPageRoute(
                    builder: (_) => const ColorShowcaseScreen(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildToolCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

