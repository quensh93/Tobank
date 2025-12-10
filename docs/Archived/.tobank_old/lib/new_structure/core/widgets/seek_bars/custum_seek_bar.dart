import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/main_theme.dart';

class CustomSeekBar extends StatefulWidget {
  final int min;
  final int max;
  final int initialValue;
  final ValueChanged<int> onChanged;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color thumbColor;
  final double activeTrackHeight; // Custom active track height
  final double inactiveTrackHeight; // Custom inactive track height
  final double thumbSize; // New parameter for thumb size

  const CustomSeekBar({
    Key? key,
    required this.min,
    required this.max,
    required this.initialValue,
    required this.onChanged,
    this.activeTrackColor = Colors.teal,
    this.inactiveTrackColor = Colors.grey,
    this.thumbColor = Colors.white,
    this.activeTrackHeight = 4.0,
    this.inactiveTrackHeight = 4.0,
    this.thumbSize = 20.0, // Default thumb size (diameter)
  })  : assert(min < max, 'Min value must be less than max value'),
        assert(initialValue >= min && initialValue <= max,
        'Initial value must be between min and max'),
        assert(activeTrackHeight > 0, 'Active track height must be greater than 0'),
        assert(inactiveTrackHeight > 0, 'Inactive track height must be greater than 0'),
        assert(thumbSize > 0, 'Thumb size must be greater than 0'),
        super(key: key);

  @override
  _CustomSeekBarState createState() => _CustomSeekBarState();
}

class _CustomSeekBarState extends State<CustomSeekBar> {
  late int _currentValue;
  late double _thumbPosition;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _updateThumbPosition();
  }

  void _updateThumbPosition() {
    final range = widget.max - widget.min;
    _thumbPosition = (_currentValue - widget.min) / range * 100; // Percentage
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final localPosition = details.localPosition.dx;
    final trackWidth = renderBox.size.width;
    final newPercentage = (localPosition / trackWidth).clamp(0.0, 1.0);
    final step = 1.0; // Step size for integer values
    final newValue = (widget.min + (newPercentage * (widget.max - widget.min)) / step).round() * step.toInt();

    if (newValue != _currentValue) {
      setState(() {
        _currentValue = newValue.clamp(widget.min, widget.max);
        _updateThumbPosition();
        widget.onChanged(_currentValue);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Row for min, current value, and max labels

        // Custom SeekBar
        GestureDetector(
          onHorizontalDragUpdate: _handleDragUpdate,
          child: Container(
            height: 48,
            child: CustomPaint(
              painter: _SeekBarPainter(
                thumbPosition: _thumbPosition,
                activeTrackColor: widget.activeTrackColor,
                inactiveTrackColor: widget.inactiveTrackColor,
                thumbColor: widget.thumbColor,
                activeTrackHeight: widget.activeTrackHeight,
                inactiveTrackHeight: widget.inactiveTrackHeight,
                thumbSize: widget.thumbSize,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.max.toString(),
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              widget.min.toString(),
              style: const TextStyle(fontSize: 14),
            ),

          ],
        ),
      ],
    );
  }
}

// Custom Painter for the SeekBar
class _SeekBarPainter extends CustomPainter {
  final double thumbPosition; // Percentage (0 to 100)
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color thumbColor;
  final double activeTrackHeight;
  final double inactiveTrackHeight;
  final double thumbSize; // Diameter of the thumb

  _SeekBarPainter({
    required this.thumbPosition,
    required this.activeTrackColor,
    required this.inactiveTrackColor,
    required this.thumbColor,
    required this.activeTrackHeight,
    required this.inactiveTrackHeight,
    required this.thumbSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw inactive track
    final inactivePaint = Paint()
      ..color = inactiveTrackColor
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, size.height / 2 - inactiveTrackHeight / 2, size.width, inactiveTrackHeight),
        const Radius.circular(10),
      ),
      inactivePaint,
    );

    // Draw active track
    final activePaint = Paint()
      ..color = activeTrackColor
      ..style = PaintingStyle.fill;
    final activeWidth = (thumbPosition / 100) * size.width;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, size.height / 2 - activeTrackHeight / 2, activeWidth, activeTrackHeight),
        const Radius.circular(10),
      ),
      activePaint,
    );

    // Draw thumb (outer circle)
    final thumbRadius = thumbSize / 2;
    final thumbCenterX = (thumbPosition / 100) * size.width;
    final thumbPaint = Paint()..color = thumbColor;
    canvas.drawCircle(
      Offset(thumbCenterX, size.height / 2),
      thumbRadius,
      thumbPaint,
    );

    // Draw inner gray circle
    final innerRadius = thumbRadius * 0.3; // 40% of thumb radius for inner circle
    final innerPaint = Paint()..color = MainTheme.of(Get.context!).white;
    canvas.drawCircle(
      Offset(thumbCenterX, size.height / 2),
      innerRadius,
      innerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _SeekBarPainter oldDelegate) {
    return thumbPosition != oldDelegate.thumbPosition ||
        activeTrackColor != oldDelegate.activeTrackColor ||
        inactiveTrackColor != oldDelegate.inactiveTrackColor ||
        thumbColor != oldDelegate.thumbColor ||
        activeTrackHeight != oldDelegate.activeTrackHeight ||
        inactiveTrackHeight != oldDelegate.inactiveTrackHeight ||
        thumbSize != oldDelegate.thumbSize;
  }
}