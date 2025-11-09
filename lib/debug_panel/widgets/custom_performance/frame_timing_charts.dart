import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// A responsive widget that displays frame timing charts for UI, Raster, and High Latency
/// based on Flutter's [FrameTiming] API.
///
/// Displays real-time performance data with customizable styling and fully responsive layout.
class FrameTimingCharts extends StatefulWidget {
  /// Creates a responsive frame timing charts widget.
  const FrameTimingCharts({
    super.key,
    this.sampleSize = 32,
    this.targetFrameTime = const Duration(microseconds: 16667),
    this.barRangeMax = const Duration(milliseconds: 50),
    this.backgroundColor,
    this.textColor,
    this.uiColor = Colors.teal,
    this.rasterColor = Colors.blue,
    this.highLatencyColor = Colors.cyan,
  });

  /// Number of recent frames to display in each chart.
  final int sampleSize;

  /// Target frame time; durations above this will be shown in red.
  final Duration targetFrameTime;

  /// Maximum expected bar duration range; durations beyond this are capped.
  final Duration barRangeMax;

  /// Background color of the charts container. Uses theme if null.
  final Color? backgroundColor;

  /// Foreground color for the text labels. Uses theme if null.
  final Color? textColor;

  /// Bar color for UI durations.
  final Color uiColor;

  /// Bar color for raster durations.
  final Color rasterColor;

  /// Bar color for total latency durations.
  final Color highLatencyColor;

  @override
  State<FrameTimingCharts> createState() => _FrameTimingChartsState();
}

/// State for managing frame timing samples and rendering charts.
class _FrameTimingChartsState extends State<FrameTimingCharts> {
  /// Recent frame timing samples.
  List<FrameTiming> _samples = const [];

  /// Whether the first sample has been skipped (to avoid warm-up noise).
  bool _skippedFirstSample = false;

  /// Prevents multiple setState calls in one frame.
  bool _pendingSetState = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addTimingsCallback(_timingsCallback);
  }

  @override
  void dispose() {
    SchedulerBinding.instance.removeTimingsCallback(_timingsCallback);
    super.dispose();
  }

  /// Callback that collects frame timing samples from the engine.
  void _timingsCallback(List<FrameTiming> frameTimings) {
    if (!mounted) return;

    // Skip the very first frame sample to avoid warm-up noise.
    final newSamples = _skippedFirstSample
        ? frameTimings
        : frameTimings.length > 1
            ? frameTimings.sublist(1)
            : const <FrameTiming>[];
    _skippedFirstSample = true;

    if (newSamples.isEmpty) return;

    final combined = <FrameTiming>[
      ..._samples,
      ...newSamples,
    ];
    final dropCount = math.max(0, combined.length - widget.sampleSize);
    final updated = combined.sublist(dropCount);

    // Prevent multiple setState calls in one frame.
    if (_pendingSetState) return;
    _pendingSetState = true;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _samples = updated;
        _pendingSetState = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = widget.backgroundColor ?? theme.colorScheme.surfaceContainerHighest;
    final textColor = widget.textColor ?? theme.colorScheme.onSurface;

    // Optimization: compute durations once
    final uiSamples = [for (final e in _samples) e.buildDuration];
    final rasterSamples = [for (final e in _samples) e.rasterDuration];
    final latencySamples = [for (final e in _samples) e.totalSpan];

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: _ResponsiveLayout(
        uiSamples: uiSamples,
        rasterSamples: rasterSamples,
        latencySamples: latencySamples,
        targetFrameTime: widget.targetFrameTime,
        barRangeMax: widget.barRangeMax,
        textColor: textColor,
        uiColor: widget.uiColor,
        rasterColor: widget.rasterColor,
        highLatencyColor: widget.highLatencyColor,
      ),
    );
  }
}

/// Responsive layout that adapts to screen size.
class _ResponsiveLayout extends StatelessWidget {
  const _ResponsiveLayout({
    required this.uiSamples,
    required this.rasterSamples,
    required this.latencySamples,
    required this.targetFrameTime,
    required this.barRangeMax,
    required this.textColor,
    required this.uiColor,
    required this.rasterColor,
    required this.highLatencyColor,
  });

  final List<Duration> uiSamples;
  final List<Duration> rasterSamples;
  final List<Duration> latencySamples;
  final Duration targetFrameTime;
  final Duration barRangeMax;
  final Color textColor;
  final Color uiColor;
  final Color rasterColor;
  final Color highLatencyColor;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isHorizontal = screenWidth > 800;

    if (isHorizontal) {
      // Horizontal layout: charts side by side
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _ChartCard(
              title: 'UI',
              samples: uiSamples,
              color: uiColor,
              targetFrameTime: targetFrameTime,
              barRangeMax: barRangeMax,
              textColor: textColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _ChartCard(
              title: 'Raster',
              samples: rasterSamples,
              color: rasterColor,
              targetFrameTime: targetFrameTime,
              barRangeMax: barRangeMax,
              textColor: textColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _ChartCard(
              title: 'High Latency',
              samples: latencySamples,
              color: highLatencyColor,
              targetFrameTime: targetFrameTime,
              barRangeMax: barRangeMax,
              textColor: textColor,
            ),
          ),
        ],
      );
    } else {
      // Vertical layout: charts stacked
      return Column(
        children: [
          _ChartCard(
            title: 'UI',
            samples: uiSamples,
            color: uiColor,
            targetFrameTime: targetFrameTime,
            barRangeMax: barRangeMax,
            textColor: textColor,
          ),
          const SizedBox(height: 16),
          _ChartCard(
            title: 'Raster',
            samples: rasterSamples,
            color: rasterColor,
            targetFrameTime: targetFrameTime,
            barRangeMax: barRangeMax,
            textColor: textColor,
          ),
          const SizedBox(height: 16),
          _ChartCard(
            title: 'High Latency',
            samples: latencySamples,
            color: highLatencyColor,
            targetFrameTime: targetFrameTime,
            barRangeMax: barRangeMax,
            textColor: textColor,
          ),
        ],
      );
    }
  }
}

/// A card containing a single performance chart with statistics.
class _ChartCard extends StatelessWidget {
  const _ChartCard({
    required this.title,
    required this.samples,
    required this.color,
    required this.targetFrameTime,
    required this.barRangeMax,
    required this.textColor,
  });

  final String title;
  final List<Duration> samples;
  final Color color;
  final Duration targetFrameTime;
  final Duration barRangeMax;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    if (samples.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: color.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'No data',
            style: TextStyle(color: textColor.withOpacity(0.5)),
          ),
        ),
      );
    }

    // Calculate statistics
    final max = samples.reduce((a, b) => a > b ? a : b);
    final avg = Duration(
      microseconds: samples.fold<int>(
        0,
        (sum, d) => sum + d.inMicroseconds,
      ) ~/ samples.length,
    );
    final fps = 1.0 / (avg.inMicroseconds / 1e6);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title and stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                '${fps.toStringAsFixed(1)} FPS',
                style: TextStyle(
                  color: textColor.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'max ${max.inMicroseconds ~/ 1000} ms',
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: 11,
                ),
              ),
              Text(
                'avg ${avg.inMicroseconds ~/ 1000} ms',
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Chart
          LayoutBuilder(
            builder: (context, constraints) {
              return _PerformanceChart(
                samples: samples,
                targetFrameTime: targetFrameTime,
                barRangeMax: barRangeMax,
                color: color,
                height: 120,
              );
            },
          ),
        ],
      ),
    );
  }
}

/// A chart widget that renders frame timings as vertical bars.
class _PerformanceChart extends StatelessWidget {
  const _PerformanceChart({
    required this.samples,
    required this.targetFrameTime,
    required this.barRangeMax,
    required this.color,
    required this.height,
  });

  final List<Duration> samples;
  final Duration targetFrameTime;
  final Duration barRangeMax;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _PerformanceChartPainter(
          samples: samples,
          targetFrameTime: targetFrameTime,
          barRangeMax: barRangeMax,
          color: color,
        ),
      ),
    );
  }
}

/// Custom painter for rendering performance bars.
class _PerformanceChartPainter extends CustomPainter {
  _PerformanceChartPainter({
    required this.samples,
    required this.targetFrameTime,
    required this.barRangeMax,
    required this.color,
  });

  final List<Duration> samples;
  final Duration targetFrameTime;
  final Duration barRangeMax;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (samples.isEmpty) return;

    final sampleSize = samples.length;
    final barWidth = size.width / sampleSize;
    final maxMs = barRangeMax.inMicroseconds;
    final targetMs = targetFrameTime.inMicroseconds;

    final paint = Paint()..style = PaintingStyle.fill;

    // Draw a horizontal line to mark the target frame time
    final lineY = size.height * (1 - (targetMs / maxMs).clamp(0.0, 1.0));
    final linePaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(0, lineY),
      Offset(size.width, lineY),
      linePaint,
    );

    // Draw bars for each sample (most recent on the right)
    for (int i = 0; i < sampleSize; i++) {
      final sample = samples[i];
      final ms = sample.inMicroseconds;
      final heightFactor = (ms / maxMs).clamp(0.0, 1.0);

      // Use red color for bars exceeding target frame time
      paint.color = ms > targetMs ? Colors.red : color;

      final rect = Rect.fromLTWH(
        i * barWidth,
        size.height * (1 - heightFactor),
        barWidth,
        size.height * heightFactor,
      );

      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(_PerformanceChartPainter oldDelegate) =>
      oldDelegate.samples != samples;
}

