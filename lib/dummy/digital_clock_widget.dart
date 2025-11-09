import 'dart:async';
import 'package:flutter/material.dart';

/// A real digital clock widget that updates every second
class DigitalClockWidget extends StatefulWidget {
  const DigitalClockWidget({
    super.key,
    this.showSeconds = true,
    this.timeFormat = '24',
    this.textStyle,
    this.backgroundColor,
    this.padding,
  });

  final bool showSeconds;
  final String timeFormat;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  @override
  State<DigitalClockWidget> createState() => _DigitalClockWidgetState();
}

class _DigitalClockWidgetState extends State<DigitalClockWidget> {
  Timer? _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentTime = DateTime.now();
        });
      }
    });
  }

  String _formatTime(DateTime time) {
    final hour = widget.timeFormat == '12'
        ? (time.hour > 12 ? time.hour - 12 : time.hour == 0 ? 12 : time.hour)
        : time.hour;

    final minute = time.minute.toString().padLeft(2, '0');
    final second = time.second.toString().padLeft(2, '0');

    String timeString = '${hour.toString().padLeft(2, '0')}:$minute';

    if (widget.showSeconds) {
      timeString += ':$second';
    }

    if (widget.timeFormat == '12') {
      timeString += time.hour >= 12 ? ' PM' : ' AM';
    }

    return timeString;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        _formatTime(_currentTime),
        style: widget.textStyle ??
            Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
