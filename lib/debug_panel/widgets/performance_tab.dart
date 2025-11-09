import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_performance_pulse/flutter_performance_pulse.dart' as pulse;
import '../state/debug_panel_settings_state.dart';
import 'custom_performance/frame_timing_data_collector.dart';
import 'custom_performance/single_frame_chart.dart';

/// Performance tab that displays real-time performance metrics
/// 
/// Shows comprehensive performance monitoring including frame timing charts
/// (UI, Raster, High Latency) and system metrics (FPS, CPU, Disk).
class PerformanceTab extends ConsumerStatefulWidget {
  const PerformanceTab({super.key});

  @override
  ConsumerState<PerformanceTab> createState() => _PerformanceTabState();
}

class _PerformanceTabState extends ConsumerState<PerformanceTab> {
  List<Duration> _uiSamples = [];
  List<Duration> _rasterSamples = [];
  List<Duration> _latencySamples = [];

  void _onFrameTimingDataCollected(
    List<Duration> uiSamples,
    List<Duration> rasterSamples,
    List<Duration> latencySamples,
  ) {
    setState(() {
      _uiSamples = uiSamples;
      _rasterSamples = rasterSamples;
      _latencySamples = latencySamples;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = ref.watch(debugPanelSettingsProvider);
    final isTrackingEnabled = settings.performanceTrackingEnabled;
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Data collector (invisible, just collects data)
          FrameTimingDataCollector(
            onDataCollected: _onFrameTimingDataCollected,
            sampleSize: settings.performanceSampleSize,
          ),
          // Main content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with controls
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.speed,
                      size: 24,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Performance Metrics',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Layout toggle button
                    IconButton(
                      icon: Icon(
                        settings.performanceLayoutMode == PerformanceLayoutMode.singleRow
                            ? Icons.grid_view
                            : Icons.view_column,
                      ),
                      onPressed: () {
                        final newMode = settings.performanceLayoutMode == PerformanceLayoutMode.singleRow
                            ? PerformanceLayoutMode.grid
                            : PerformanceLayoutMode.singleRow;
                        ref.read(debugPanelSettingsProvider.notifier).setPerformanceLayoutMode(newMode);
                      },
                    ),
                    const SizedBox(width: 8),
                    Switch(
                      value: isTrackingEnabled,
                      onChanged: (value) {
                        ref.read(debugPanelSettingsProvider.notifier).setPerformanceTrackingEnabled(value);
                      },
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isTrackingEnabled ? 'ON' : 'OFF',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              
              // Info section - made more compact
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Frame timing (UI, Raster, Latency) and system metrics (FPS, CPU, Disk).',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Sample size control
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.tune,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Samples:',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(width: 8),
                    // Decrease button
                    IconButton(
                      icon: const Icon(Icons.remove),
                      iconSize: 16,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                      onPressed: settings.performanceSampleSize > 8
                          ? () {
                              final newValue = (((settings.performanceSampleSize / 8).floor() - 1) * 8).clamp(8, 1000);
                              ref.read(debugPanelSettingsProvider.notifier).setPerformanceSampleSize(newValue);
                            }
                          : null,
                    ),
                    // Value display
                    SizedBox(
                      width: 80,
                      child: Text(
                        '${settings.performanceSampleSize}',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Increase button
                    IconButton(
                      icon: const Icon(Icons.add),
                      iconSize: 16,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                      onPressed: settings.performanceSampleSize < 1000
                          ? () {
                              final newValue = (((settings.performanceSampleSize / 8).floor() + 1) * 8).clamp(8, 1000);
                              ref.read(debugPanelSettingsProvider.notifier).setPerformanceSampleSize(newValue);
                            }
                          : null,
                    ),
                    const Spacer(),
                    // Range info
                    Text(
                      '(8-1000)',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Performance charts container
              Expanded(
                child: _buildPerformanceCharts(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCharts(BuildContext context) {
    final settings = ref.watch(debugPanelSettingsProvider);
    final isTrackingEnabled = settings.performanceTrackingEnabled;

    if (!isTrackingEnabled) {
      return _buildPausedState(context);
    }

    final theme = Theme.of(context);
    final layoutMode = settings.performanceLayoutMode;
    
    // Show charts based on layout mode
    if (layoutMode == PerformanceLayoutMode.singleRow) {
      return _buildSingleRowLayout(context, theme);
    } else {
      return _buildGridLayout(context, theme);
    }
  }

  Widget _buildSingleRowLayout(BuildContext context, ThemeData theme) {
    return Container(
      width: double.infinity,
      color: theme.colorScheme.surfaceContainerHighest,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // UI Chart
              ClipRect(
                child: SizedBox(
                  width: 300,
                  child: _buildSingleChart(context, theme, 'UI', Colors.teal, 0),
                ),
              ),
              const SizedBox(width: 16),
              // Raster Chart
              ClipRect(
                child: SizedBox(
                  width: 300,
                  child: _buildSingleChart(context, theme, 'Raster', Colors.blue, 1),
                ),
              ),
              const SizedBox(width: 16),
              // High Latency Chart
              ClipRect(
                child: SizedBox(
                  width: 300,
                  child: _buildSingleChart(context, theme, 'High Latency', Colors.cyan, 2),
                ),
              ),
              const SizedBox(width: 16),
              // System Metrics
              ClipRect(
                child: SizedBox(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'System',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      pulse.PerformanceDashboard(
                        showFPS: true,
                        showCPU: true,
                        showDisk: true,
                        theme: pulse.DashboardTheme(
                          backgroundColor: theme.colorScheme.surfaceContainerHighest,
                          textColor: theme.colorScheme.onSurface,
                          warningColor: Colors.orange,
                          errorColor: Colors.red,
                          chartLineColor: theme.colorScheme.primary,
                          chartFillColor: theme.colorScheme.primary.withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridLayout(BuildContext context, ThemeData theme) {
    return Container(
      width: double.infinity,
      color: theme.colorScheme.surfaceContainerHighest,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Each diagram in its own row (vertically stacked)
            // UI Chart
            ClipRect(
              child: _buildSingleChart(context, theme, 'UI', Colors.teal, 0),
            ),
            const SizedBox(height: 16),
            // Raster Chart
            ClipRect(
              child: _buildSingleChart(context, theme, 'Raster', Colors.blue, 1),
            ),
            const SizedBox(height: 16),
            // High Latency Chart
            ClipRect(
              child: _buildSingleChart(context, theme, 'High Latency', Colors.cyan, 2),
            ),
            const SizedBox(height: 16),
            // System Metrics
            ClipRect(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'System Metrics',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  pulse.PerformanceDashboard(
                    showFPS: true,
                    showCPU: true,
                    showDisk: true,
                    theme: pulse.DashboardTheme(
                      backgroundColor: theme.colorScheme.surfaceContainerHighest,
                      textColor: theme.colorScheme.onSurface,
                      warningColor: Colors.orange,
                      errorColor: Colors.red,
                      chartLineColor: theme.colorScheme.primary,
                      chartFillColor: theme.colorScheme.primary.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleChart(BuildContext context, ThemeData theme, String title, Color color, int chartIndex) {
    final samples = switch (chartIndex) {
      0 => _uiSamples,
      1 => _rasterSamples,
      2 => _latencySamples,
      _ => <Duration>[],
    };

    return SingleFrameChart(
      title: title,
      samples: samples,
      color: color,
      targetFrameTime: const Duration(microseconds: 16667),
      barRangeMax: const Duration(milliseconds: 50),
      textColor: theme.colorScheme.onSurface,
      showFps: chartIndex == 2, // Only show FPS for High Latency (total frame time)
    );
  }

  Widget _buildPausedState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pause_circle_outline,
              size: 64,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'Performance Tracking Paused',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Enable tracking to view real-time performance metrics.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
