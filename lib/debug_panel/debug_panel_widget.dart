import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:device_frame/device_frame.dart';
import '../core/helpers/logger.dart';
import 'state/device_preview_state.dart';
import 'state/debug_panel_settings_state.dart';
import 'themes/debug_panel_theme.dart';
import 'widgets/device_preview_tab.dart';
import 'widgets/logs_tab.dart';
import 'widgets/performance_tab.dart';
import 'widgets/network_tab.dart';
import 'widgets/settings_tab.dart';

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

    // Watch debugPanelEnabled from state — when disabled, skip the layout
    // entirely and just show the app. The "Tools" button in the draggable
    // panel (ISpect) still allows re-enabling from the bottom sheet.
    final debugPanelEnabled = ref.watch(
      debugPanelSettingsProvider.select((s) => s.debugPanelEnabled),
    );

    if (!debugPanelEnabled) {
      return widget.child;
    }

    return DebugPanelProvider(
      tools: widget.tools,
      child: _LayoutSelector(child: widget.child),
    );
  }
}

/// Widget that selects the appropriate layout based on settings and constraints
class _LayoutSelector extends ConsumerWidget {
  const _LayoutSelector({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only watch layout-related settings, not all settings
    // This prevents unnecessary rebuilds when only tab index or other non-layout settings change
    final layoutMode = ref.watch(
      debugPanelSettingsProvider.select((state) => state.layoutMode),
    );

    AppLogger.d(
      'ðŸ”„ _LayoutSelector building - Layout mode: ${layoutMode.name}',
    );

    return LayoutBuilder(
      key: ValueKey('layout_builder_${layoutMode.name}'),
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 700;

        AppLogger.d(
          'ðŸ—ï¸ Building debug panel layout - Mode: ${layoutMode.name}, isSmall: $isSmall, width: ${constraints.maxWidth}',
        );

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

        AppLogger.d('âœ… Returning $layoutKey layout widget');
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
        delegates: const [
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
  const DebugPanelLargeLayout({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<DebugPanelLargeLayout> createState() =>
      _DebugPanelLargeLayoutState();
}

class _DebugPanelLargeLayoutState extends ConsumerState<DebugPanelLargeLayout> {
  static const double _minPanelWidth = 0.2; // Minimum 20% width
  static const double _maxPanelWidth = 0.8; // Maximum 80% width
  static const double _minPanelHeight = 300.0; // Minimum height for both panels

  double?
      _dragPanelWidth; // Local state during dragging, null when not dragging

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(debugPanelSettingsProvider);
    final controller = ref.read(debugPanelSettingsProvider.notifier);
    // Use local drag state if available, otherwise use saved state
    final leftPanelWidth = _dragPanelWidth ?? settings.leftPanelWidth;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;
            final availableHeight = constraints.maxHeight;
            const dividerWidth = 8.0;
            final usableWidth = availableWidth - dividerWidth;

            final leftFlex = settings.areToolsVisible
                ? (leftPanelWidth * 1000).round()
                : 1000;

            return Row(
              children: [
                // Left panel (device preview) - full size outer border
                Expanded(
                  flex: leftFlex,
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
                if (settings.areToolsVisible) ...[
                  GestureDetector(
                    onPanStart: (_) {
                      // Initialize drag state with current value
                      _dragPanelWidth = settings.leftPanelWidth;
                    },
                    onPanUpdate: (details) {
                      final currentWidth =
                          _dragPanelWidth ?? settings.leftPanelWidth;
                      final delta = details.delta.dx;
                      final newLeftWidth =
                          (currentWidth * usableWidth + delta) / usableWidth;
                      final clampedWidth = newLeftWidth.clamp(
                        _minPanelWidth,
                        _maxPanelWidth,
                      );

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
                                color: Theme.of(
                                  context,
                                ).colorScheme.outline.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Container(
                                  width: 2,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .outline
                                        .withValues(alpha: 0.4),
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
                    flex: ((1 - leftPanelWidth) * 1000)
                        .round(), // Convert to flex units
                    child: const SizedBox(
                      height: double.infinity, // Full height
                      child: ToolPanel(),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
    );
  }
}

/// Responsive layout for small screens (mobile)
/// Implements a true Bottom Sheet behavior using Stack
class DebugPanelSmallLayout extends ConsumerStatefulWidget {
  const DebugPanelSmallLayout({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<DebugPanelSmallLayout> createState() =>
      _DebugPanelSmallLayoutState();
}

class _DebugPanelSmallLayoutState extends ConsumerState<DebugPanelSmallLayout> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final areToolsVisible = ref.watch(
      debugPanelSettingsProvider.select((state) => state.areToolsVisible),
    );
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculated heights
    final double collapsedHeight = 60 +
        MediaQuery.of(context).padding.bottom +
        40; // 60 tab + padding + 40 handle (Total ~100 + padding)
    final double expandedHeight = screenHeight * 0.85; // Cover 85% of screen

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          // 1. App Layer
          // Reserve space at the bottom for the collapsed panel so it doesn't overlap the device frame
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: areToolsVisible ? collapsedHeight : 0,
            child: AppFrame(
              key: const ValueKey('app_frame_small'),
              child: widget.child,
            ),
          ),

          // 2. Dimming Layer (optional, when expanded)
          if (_isExpanded && areToolsVisible)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => setState(() => _isExpanded = false),
                child: Container(color: Colors.black.withValues(alpha: 0.5)),
              ),
            ),

          // 3. Bottom Sheet Debug Panel
          if (areToolsVisible)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              left: 0,
              right: 0,
              bottom: 0,
              height: _isExpanded ? expandedHeight : collapsedHeight,
              child: _MobileBottomSheetPanel(
                isExpanded: _isExpanded,
                onToggle: () => setState(() => _isExpanded = !_isExpanded),
                onClose: () => setState(() => _isExpanded = false),
              ),
            ),
        ],
      ),
    );
  }
}

/// Mobile bottom sheet panel with drag handle and expandable content
class _MobileBottomSheetPanel extends ConsumerStatefulWidget {
  const _MobileBottomSheetPanel({
    required this.isExpanded,
    required this.onToggle,
    required this.onClose,
  });

  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback onClose;

  @override
  ConsumerState<_MobileBottomSheetPanel> createState() =>
      _MobileBottomSheetPanelState();
}

class _MobileBottomSheetPanelState
    extends ConsumerState<_MobileBottomSheetPanel>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _tabBarScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabBarScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(debugPanelSettingsProvider);
    final targetIndex = settings.selectedTabIndex.clamp(0, 4);

    // Sync tab index
    if (_tabController.index != targetIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _tabController.index != targetIndex) {
          _tabController.animateTo(targetIndex);
        }
      });
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Drag Handle Area
              GestureDetector(
                onTap: widget.onToggle,
                onVerticalDragEnd: (details) {
                  // Swipe up to expand, swipe down to collapse
                  if (details.primaryVelocity != null) {
                    if (details.primaryVelocity! < -100 && !widget.isExpanded) {
                      widget.onToggle(); // Expand
                    } else if (details.primaryVelocity! > 100 &&
                        widget.isExpanded) {
                      widget.onClose(); // Collapse
                    }
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.transparent, // Hit test
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Balance spacer
                      if (widget.isExpanded) const SizedBox(width: 48),
                      // Drag indicator
                      Container(
                        width: 48,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),
                      // Close button when expanded
                      if (widget.isExpanded)
                        SizedBox(
                          width: 48,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: InkWell(
                                onTap: widget.onClose,
                                borderRadius: BorderRadius.circular(12),
                                child: const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Tabs - Always visible
              ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.stylus,
                    PointerDeviceKind.trackpad,
                    PointerDeviceKind.unknown,
                  },
                ),
                child: Listener(
                  onPointerSignal: (event) {
                    if (event is PointerScrollEvent) {
                      final delta = event.scrollDelta.dy;
                      if (delta == 0) return;
                      final newOffset = _tabBarScrollController.offset + delta;
                      _tabBarScrollController.jumpTo(
                        newOffset.clamp(
                          _tabBarScrollController.position.minScrollExtent,
                          _tabBarScrollController.position.maxScrollExtent,
                        ),
                      );
                    }
                  },
                  child: SingleChildScrollView(
                    controller: _tabBarScrollController,
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        onTap: (index) {
                          ref
                              .read(debugPanelSettingsProvider.notifier)
                              .setSelectedTabIndex(index);
                          // Auto-expand when tapping a tab if collapsed
                          if (!widget.isExpanded) {
                            widget.onToggle();
                          }
                        },
                        tabs: [
                          _buildTab(Icons.phone_android, 'Device', settings),
                          _buildTab(Icons.bug_report, 'Logs', settings),
                          _buildTab(Icons.speed, 'Perf', settings),
                          _buildTab(Icons.network_check, 'Network', settings),
                          _buildTab(Icons.settings, 'Settings', settings),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Expanded Content
              if (widget.isExpanded)
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      DevicePreviewTab(),
                      LogsTab(),
                      PerformanceTab(),
                      NetworkTab(),
                      SettingsTab(),
                    ],
                  ),
                ),
            ],
          ),
        ),
    );
  }

  Tab _buildTab(IconData icon, String label, DebugPanelSettingsState state) {
    return Tab(
      height: 48,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: state.uiSize.iconSize),
          if (widget.isExpanded) ...[const SizedBox(width: 8), Text(label)],
        ],
      ),
    );
  }
}

/// Vertical layout (top-bottom) for debug panel
class DebugPanelVerticalLayout extends ConsumerStatefulWidget {
  const DebugPanelVerticalLayout({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<DebugPanelVerticalLayout> createState() =>
      _DebugPanelVerticalLayoutState();
}

class _DebugPanelVerticalLayoutState
    extends ConsumerState<DebugPanelVerticalLayout> {
  static const double _minPanelHeight = 0.2; // Minimum 20% height
  static const double _maxPanelHeight = 0.8; // Maximum 80% height
  static const double _minPanelHeightPx = 200.0; // Minimum 200px height

  double?
      _dragPanelHeight; // Local state during dragging, null when not dragging

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(debugPanelSettingsProvider);
    final controller = ref.read(debugPanelSettingsProvider.notifier);
    // Use local drag state if available, otherwise use saved state
    final topPanelHeight = _dragPanelHeight ?? settings.topPanelHeight;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;
            const dividerHeight = 8.0;
            final usableHeight = availableHeight - dividerHeight;

            final topFlex = settings.areToolsVisible
                ? (topPanelHeight * 1000).round()
                : 1000;

            return Column(
              children: [
                // Top panel (device preview)
                Expanded(
                  flex: topFlex,
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
                // Resizable divider and tools
                if (settings.areToolsVisible) ...[
                  GestureDetector(
                    onPanStart: (_) {
                      // Initialize drag state with current value
                      _dragPanelHeight = settings.topPanelHeight;
                    },
                    onPanUpdate: (details) {
                      final currentHeight =
                          _dragPanelHeight ?? settings.topPanelHeight;
                      final delta = details.delta.dy;
                      final newTopHeight =
                          (currentHeight * usableHeight + delta) / usableHeight;
                      final clampedHeight = newTopHeight.clamp(
                        _minPanelHeight,
                        _maxPanelHeight,
                      );

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
                                color: Theme.of(
                                  context,
                                ).colorScheme.outline.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Container(
                                  width: 40,
                                  height: 2,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .outline
                                        .withValues(alpha: 0.4),
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
                  // Bottom panel (debug panel)
                  Expanded(
                    flex: ((1 - topPanelHeight) * 1000).round(),
                    child: const SizedBox(
                      width: double.infinity, // Full width
                      child: ToolPanel(isVertical: true),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
    );
  }
}

/// App frame that shows the current app state with device preview
class AppFrame extends ConsumerWidget {
  const AppFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceState = ref.watch(devicePreviewProvider);

    // When device preview is off, render the app directly without any frame
    if (!deviceState.isPreviewEnabled) {
      return SizedBox(
        key: const ValueKey('app_frame'),
        width: double.infinity,
        height: double.infinity,
        child: RepaintBoundary(
          key: const ValueKey('app_frame_content'),
          child: child,
        ),
      );
    }

    // Device preview is on — show the decorative frame around the device
    return Container(
      key: const ValueKey('app_frame'),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.5),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: RepaintBoundary(
              key: const ValueKey('app_frame_content'),
              child: _buildDevicePreview(context, deviceState),
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

class _ToolPanelState extends ConsumerState<ToolPanel>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _tabBarScrollController = ScrollController();
  bool _isRestoringTab = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _tabBarScrollController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    // Only save tab changes if we're not currently restoring a tab
    if (!_isRestoringTab && !_tabController.indexIsChanging) {
      final currentIndex =
          ref.read(debugPanelSettingsProvider).selectedTabIndex;
      if (_tabController.index != currentIndex) {
        ref
            .read(debugPanelSettingsProvider.notifier)
            .setSelectedTabIndex(_tabController.index);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(debugPanelSettingsProvider);

    // Restore saved tab index when settings change
    final targetIndex = settings.selectedTabIndex.clamp(0, 4);
    if (_tabController.index != targetIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_tabController.index != targetIndex) {
          _isRestoringTab = true;
          _tabController.animateTo(targetIndex);
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
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.2),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 4.0,
                      ),
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          },
                        ),
                        child: Listener(
                          onPointerSignal: (event) {
                            if (event is PointerScrollEvent) {
                              final delta = event.scrollDelta.dy;
                              if (delta == 0) return;
                              final newOffset =
                                  _tabBarScrollController.offset + delta;
                              _tabBarScrollController.jumpTo(
                                newOffset.clamp(
                                  _tabBarScrollController
                                      .position.minScrollExtent,
                                  _tabBarScrollController
                                      .position.maxScrollExtent,
                                ),
                              );
                            }
                          },
                          child: SingleChildScrollView(
                            controller: _tabBarScrollController,
                            scrollDirection: Axis.horizontal,
                            child: TabBar(
                              controller: _tabController,
                              tabs: [
                                Tab(
                                  icon: Icon(
                                    Icons.phone_android,
                                    size: settings.uiSize.iconSize,
                                  ),
                                  text: 'Device',
                                ),
                                Tab(
                                  icon: Icon(
                                    Icons.bug_report,
                                    size: settings.uiSize.iconSize,
                                  ),
                                  text: 'Logs',
                                ),
                                Tab(
                                  icon: Icon(
                                    Icons.speed,
                                    size: settings.uiSize.iconSize,
                                  ),
                                  text: 'Performance',
                                ),
                                Tab(
                                  icon: Icon(
                                    Icons.network_check,
                                    size: settings.uiSize.iconSize,
                                  ),
                                  text: 'Network',
                                ),
                                Tab(
                                  icon: Icon(
                                    Icons.settings,
                                    size: settings.uiSize.iconSize,
                                  ),
                                  text: 'Settings',
                                ),
                              ],
                              isScrollable: true,
                              tabAlignment: widget.isMobile
                                  ? TabAlignment.start
                                  : TabAlignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Tab content - UI size will be applied within each tab
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: const [
                          DevicePreviewTab(),
                          LogsTab(),
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
  static const double mobilePanelHeight =
      200.0; // Further reduced height to prevent overflow
  static const double breakpoint = 700.0;
}
