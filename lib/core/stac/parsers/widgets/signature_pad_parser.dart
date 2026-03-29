import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../utils/registry_notifier.dart';

class SignaturePadModel {
  const SignaturePadModel({
    this.valueKey,
    this.hasSignatureKey,
    this.clearKey,
    this.strokeColor,
    this.backgroundColor,
    this.strokeWidth = 3,
  });

  final String? valueKey;
  final String? hasSignatureKey;
  final String? clearKey;
  final String? strokeColor;
  final String? backgroundColor;
  final double strokeWidth;

  factory SignaturePadModel.fromJson(Map<String, dynamic> json) {
    return SignaturePadModel(
      valueKey: json['valueKey'] as String?,
      hasSignatureKey: json['hasSignatureKey'] as String?,
      clearKey: json['clearKey'] as String?,
      strokeColor: json['strokeColor'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 3,
    );
  }
}

class SignaturePadParser extends StacParser<SignaturePadModel> {
  const SignaturePadParser();

  @override
  String get type => 'signaturePad';

  @override
  SignaturePadModel getModel(Map<String, dynamic> json) {
    return SignaturePadModel.fromJson(json);
  }

  @override
  Widget parse(BuildContext context, SignaturePadModel model) {
    return _SignaturePad(model: model);
  }
}

class _SignaturePad extends StatefulWidget {
  const _SignaturePad({required this.model});

  final SignaturePadModel model;

  @override
  State<_SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<_SignaturePad> {
  final List<List<Offset>> _strokes = <List<Offset>>[];
  List<Offset>? _activeStroke;

  Size _canvasSize = Size.zero;
  Object? _lastClearToken;
  bool? _lastPublishedHasSignature;
  String? _lastPublishedValue;

  @override
  void initState() {
    super.initState();
    _lastClearToken = _readRegistryValue(widget.model.clearKey);
    RegistryNotifier.instance.listenable.addListener(_handleRegistryChanged);
    _publishEmptyState(force: true);
  }

  @override
  void dispose() {
    RegistryNotifier.instance.listenable.removeListener(_handleRegistryChanged);
    super.dispose();
  }

  void _handleRegistryChanged() {
    final currentClearToken = _readRegistryValue(widget.model.clearKey);
    if (currentClearToken == _lastClearToken) {
      return;
    }

    _lastClearToken = currentClearToken;
    _clearSignature(force: true);
  }

  Object? _readRegistryValue(String? key) {
    if (key == null || key.isEmpty) {
      return null;
    }
    return StacRegistry.instance.getValue(key);
  }

  void _startStroke(DragStartDetails details) {
    final offset = _clampOffset(details.localPosition);
    setState(() {
      _activeStroke = <Offset>[offset];
      _strokes.add(_activeStroke!);
    });
    _publishHasSignature(true);
  }

  void _appendPoint(DragUpdateDetails details) {
    if (_activeStroke == null) {
      return;
    }

    setState(() {
      _activeStroke!.add(_clampOffset(details.localPosition));
    });
  }

  Future<void> _endStroke(DragEndDetails details) async {
    _activeStroke = null;
    await _publishSignatureValue();
  }

  Offset _clampOffset(Offset offset) {
    final width = _canvasSize.width;
    final height = _canvasSize.height;

    if (width <= 0 || height <= 0) {
      return offset;
    }

    return Offset(
      offset.dx.clamp(0.0, width),
      offset.dy.clamp(0.0, height),
    );
  }

  void _clearSignature({bool force = false}) {
    if (_strokes.isNotEmpty || force) {
      setState(() {
        _strokes.clear();
        _activeStroke = null;
      });
    }
    _publishEmptyState(force: true);
  }

  void _publishHasSignature(bool value, {bool force = false}) {
    final hasSignatureKey = widget.model.hasSignatureKey;
    if (hasSignatureKey == null || hasSignatureKey.isEmpty) {
      return;
    }

    if (!force && _lastPublishedHasSignature == value) {
      return;
    }

    _lastPublishedHasSignature = value;
    StacRegistry.instance.setValue(hasSignatureKey, value);
    RegistryNotifier.instance.notify();
  }

  void _publishEmptyState({bool force = false}) {
    _publishHasSignature(false, force: force);

    final valueKey = widget.model.valueKey;
    if (valueKey == null || valueKey.isEmpty) {
      return;
    }

    if (!force && _lastPublishedValue == '') {
      return;
    }

    _lastPublishedValue = '';
    StacRegistry.instance.setValue(valueKey, '');
    RegistryNotifier.instance.notify();
  }

  Future<void> _publishSignatureValue() async {
    _publishHasSignature(_strokes.isNotEmpty, force: true);

    final valueKey = widget.model.valueKey;
    if (valueKey == null || valueKey.isEmpty || _canvasSize.isEmpty) {
      return;
    }

    final exported = await _exportSignatureAsBase64();
    if (_lastPublishedValue == exported) {
      return;
    }

    _lastPublishedValue = exported;
    StacRegistry.instance.setValue(valueKey, exported);
    RegistryNotifier.instance.notify();
  }

  Future<String> _exportSignatureAsBase64() async {
    if (_strokes.isEmpty || _canvasSize.isEmpty) {
      return '';
    }

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final size = _canvasSize;

    final backgroundColor = _resolveColor(
      widget.model.backgroundColor,
      fallback: Colors.transparent,
    );

    if (backgroundColor.a > 0) {
      canvas.drawRect(
        Offset.zero & size,
        Paint()..color = backgroundColor,
      );
    }

    _paintStrokes(
      canvas: canvas,
      strokeColor: _resolveColor(widget.model.strokeColor),
      strokeWidth: widget.model.strokeWidth,
      strokes: _strokes,
    );

    final picture = recorder.endRecording();
    final image = await picture.toImage(
      size.width.ceil().clamp(1, 4096),
      size.height.ceil().clamp(1, 4096),
    );
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      return '';
    }

    final bytes = Uint8List.view(byteData.buffer);
    return base64Encode(bytes);
  }

  Color _resolveColor(String? value, {Color fallback = Colors.black}) {
    if (value == null || value.isEmpty) {
      return fallback;
    }

    if (value.toLowerCase().trim() == 'transparent') {
      return Colors.transparent;
    }

    if (value.startsWith('{{') && value.endsWith('}}')) {
      final key = value.substring(2, value.length - 2);
      final resolved = StacRegistry.instance.getValue(key);
      if (resolved is String) {
        return _hexToColor(resolved) ?? fallback;
      }
      if (resolved is Color) {
        return resolved;
      }
    }

    return _hexToColor(value) ?? fallback;
  }

  Color? _hexToColor(String hex) {
    var normalized = hex.replaceAll('#', '').trim();
    if (normalized.isEmpty) {
      return null;
    }

    if (normalized.length == 6) {
      normalized = 'FF$normalized';
    }

    return Color(int.parse(normalized, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _resolveColor(
      widget.model.backgroundColor,
      fallback: Colors.transparent,
    );
    final strokeColor = _resolveColor(widget.model.strokeColor);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : _canvasSize.width;
        final height = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : _canvasSize.height;

        final nextSize = Size(
          width <= 0 ? 1 : width,
          height <= 0 ? 1 : height,
        );

        if (_canvasSize != nextSize) {
          _canvasSize = nextSize;
        }

        return ColoredBox(
          color: backgroundColor,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanStart: _startStroke,
            onPanUpdate: _appendPoint,
            onPanEnd: _endStroke,
            child: CustomPaint(
              painter: _SignaturePainter(
                strokes: _strokes,
                strokeColor: strokeColor,
                strokeWidth: widget.model.strokeWidth,
              ),
              size: Size.infinite,
              child: const SizedBox.expand(),
            ),
          ),
        );
      },
    );
  }
}

class _SignaturePainter extends CustomPainter {
  const _SignaturePainter({
    required this.strokes,
    required this.strokeColor,
    required this.strokeWidth,
  });

  final List<List<Offset>> strokes;
  final Color strokeColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    _paintStrokes(
      canvas: canvas,
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
      strokes: strokes,
    );
  }

  @override
  bool shouldRepaint(covariant _SignaturePainter oldDelegate) {
    return oldDelegate.strokes != strokes ||
        oldDelegate.strokeColor != strokeColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

void _paintStrokes({
  required Canvas canvas,
  required Color strokeColor,
  required double strokeWidth,
  required List<List<Offset>> strokes,
}) {
  final linePaint = Paint()
    ..color = strokeColor
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;

  final dotPaint = Paint()
    ..color = strokeColor
    ..style = PaintingStyle.fill;

  for (final stroke in strokes) {
    if (stroke.isEmpty) {
      continue;
    }

    if (stroke.length == 1) {
      canvas.drawCircle(stroke.first, strokeWidth / 2, dotPaint);
      continue;
    }

    final path = Path()..moveTo(stroke.first.dx, stroke.first.dy);
    for (var i = 1; i < stroke.length; i++) {
      path.lineTo(stroke[i].dx, stroke[i].dy);
    }
    canvas.drawPath(path, linePaint);
  }
}
