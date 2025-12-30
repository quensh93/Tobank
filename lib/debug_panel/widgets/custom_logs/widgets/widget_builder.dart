import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ispectify/ispectify.dart';

typedef ISpectifyWidgetBuilder = Widget Function(
  BuildContext context,
  List<ISpectLogData> data,
);

/// Builder widget for ISpectLogger data streams.
///
/// Supports both Throttling and Debouncing to optimize performance.
/// - [useDebounce]: If true, waits for silence before updating (good for bursts).
/// - Default is Throttle: Updates periodically (good for streaming).
class ISpectifyBuilder extends StatefulWidget {
  const ISpectifyBuilder({
    required this.iSpectLogger,
    required this.builder,
    this.useDebounce = false,
    this.updateInterval = const Duration(milliseconds: 500),
    super.key,
  });

  final ISpectLogger iSpectLogger;
  final ISpectifyWidgetBuilder builder;
  final bool useDebounce;
  final Duration updateInterval;

  @override
  State<ISpectifyBuilder> createState() => _ISpectifyBuilderState();
}

class _ISpectifyBuilderState extends State<ISpectifyBuilder> {
  List<ISpectLogData> _cachedData = [];
  StreamSubscription<ISpectLogData>? _subscription;
  Timer? _updateTimer;
  Timer? _clearCheckTimer;
  bool _pendingUpdate = false;
  bool _isFirstBuild = true;

  @override
  void initState() {
    super.initState();
    _cachedData = widget.iSpectLogger.history;

    _subscription = widget.iSpectLogger.stream.listen((_) {
      _scheduleUpdate();
    });

    // Periodically check for clears
    _clearCheckTimer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      _checkForClear();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _updateTimer?.cancel();
    _clearCheckTimer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(ISpectifyBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.iSpectLogger != widget.iSpectLogger) {
      _subscription?.cancel();
      _cachedData = widget.iSpectLogger.history;
      _subscription = widget.iSpectLogger.stream.listen((_) {
        _scheduleUpdate();
      });
    }
  }

  void _checkForClear() {
    if (!mounted) return;
    if (widget.iSpectLogger.history.length < _cachedData.length) {
      _updateTimer?.cancel();
      _pendingUpdate = false;
      setState(() {
        _cachedData = widget.iSpectLogger.history;
      });
    }
  }

  void _scheduleUpdate() {
    // For Debounce: Cancel pending timer to restart the wait
    if (widget.useDebounce) {
      _updateTimer?.cancel();
    } else {
      // For Throttle: If timer is running, just mark pending (do not cancel)
      _pendingUpdate = true;
      if (_updateTimer?.isActive ?? false) return;
    }

    _updateTimer = Timer(widget.updateInterval, () {
      if (mounted) {
        _pendingUpdate = false;
        // In debounce mode, we always update when timer fires.
        // In throttle mode, we update only if there was a pending change (or timer expired).
        setState(() {
          _cachedData = widget.iSpectLogger.history;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstBuild) {
      _isFirstBuild = false;
      _cachedData = widget.iSpectLogger.history;
    }
    return widget.builder(context, _cachedData);
  }
}
