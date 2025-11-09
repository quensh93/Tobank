import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// A widget that collects frame timing data and provides it via callback.
class FrameTimingDataCollector extends StatefulWidget {
  const FrameTimingDataCollector({
    super.key,
    required this.onDataCollected,
    this.sampleSize = 32,
  });

  /// Callback function that receives the collected frame timing data.
  final Function(List<Duration> uiSamples, List<Duration> rasterSamples, List<Duration> latencySamples) onDataCollected;

  /// Number of recent frames to collect.
  final int sampleSize;

  @override
  State<FrameTimingDataCollector> createState() => _FrameTimingDataCollectorState();
}

class _FrameTimingDataCollectorState extends State<FrameTimingDataCollector> {
  List<FrameTiming> _samples = const [];
  bool _skippedFirstSample = false;
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

  void _timingsCallback(List<FrameTiming> frameTimings) {
    if (!mounted) return;

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

    if (_pendingSetState) return;
    _pendingSetState = true;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _samples = updated;
        _pendingSetState = false;
        
        // Calculate and provide samples to callback
        final uiSamples = [for (final e in _samples) e.buildDuration];
        final rasterSamples = [for (final e in _samples) e.rasterDuration];
        final latencySamples = [for (final e in _samples) e.totalSpan];
        
        widget.onDataCollected(uiSamples, rasterSamples, latencySamples);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

