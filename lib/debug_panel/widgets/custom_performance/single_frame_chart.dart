import 'package:flutter/material.dart';

/// A single frame timing chart widget that displays a chart for one type of frame timing.
class SingleFrameChart extends StatelessWidget {
  const SingleFrameChart({
    super.key,
    required this.title,
    required this.samples,
    required this.color,
    required this.targetFrameTime,
    required this.barRangeMax,
    required this.textColor,
    this.showFps = false,
  });

  final String title;
  final List<Duration> samples;
  final Color color;
  final Duration targetFrameTime;
  final Duration barRangeMax;
  final Color textColor;
  final bool showFps;

  @override
  Widget build(BuildContext context) {
    if (samples.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: color.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'No data',
            style: TextStyle(color: textColor.withValues(alpha: 0.5)),
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
          ) ~/
          samples.length,
    );
    final fps = 1.0 / (avg.inMicroseconds / 1e6);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: color.withValues(alpha: 0.3)),
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
              if (showFps)
                Text(
                  '${fps.toStringAsFixed(1)} FPS',
                  style: TextStyle(
                    color: textColor.withValues(alpha: 0.7),
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
                  color: textColor.withValues(alpha: 0.6),
                  fontSize: 11,
                ),
              ),
              Text(
                'avg ${avg.inMicroseconds ~/ 1000} ms',
                style: TextStyle(
                  color: textColor.withValues(alpha: 0.6),
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
      ..color = Colors.black.withValues(alpha: 0.3)
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
