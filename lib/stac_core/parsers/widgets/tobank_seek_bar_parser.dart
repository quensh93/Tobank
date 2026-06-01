import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../registry/custom_component_registry.dart';
import '../../registry/registry_notifier.dart';

class TobankSeekBarModel {
  const TobankSeekBarModel({
    this.id,
    this.min = 0,
    this.max = 100,
    this.initialValue = 0,
    this.activeTrackHeight = 4,
    this.inactiveTrackHeight = 4,
    this.thumbSize = 20,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
    this.onChanged,
    this.perInstallmentAmountKey,
    this.computedAmountDestinationKey,
  });

  final String? id;
  final double min;
  final double max;
  final double initialValue;
  final double activeTrackHeight;
  final double inactiveTrackHeight;
  final double thumbSize;
  final String? activeTrackColor;
  final String? inactiveTrackColor;
  final String? thumbColor;
  final Map<String, dynamic>? onChanged;
  final String? perInstallmentAmountKey;
  final String? computedAmountDestinationKey;

  factory TobankSeekBarModel.fromJson(Map<String, dynamic> json) {
    return TobankSeekBarModel(
      id: json['id'] as String?,
      min: _toDouble(json['min']) ?? 0,
      max: _toDouble(json['max']) ?? 100,
      initialValue: _toDouble(json['initialValue']) ?? 0,
      activeTrackHeight: _toDouble(json['activeTrackHeight']) ?? 4,
      inactiveTrackHeight: _toDouble(json['inactiveTrackHeight']) ?? 4,
      thumbSize: _toDouble(json['thumbSize']) ?? 20,
      activeTrackColor: json['activeTrackColor'] as String?,
      inactiveTrackColor: json['inactiveTrackColor'] as String?,
      thumbColor: json['thumbColor'] as String?,
      onChanged: json['onChanged'] is Map
          ? Map<String, dynamic>.from(json['onChanged'] as Map)
          : null,
      perInstallmentAmountKey: json['perInstallmentAmountKey'] as String?,
      computedAmountDestinationKey:
          json['computedAmountDestinationKey'] as String?,
    );
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) {
      final normalized = value
          .replaceAll('۰', '0')
          .replaceAll('۱', '1')
          .replaceAll('۲', '2')
          .replaceAll('۳', '3')
          .replaceAll('۴', '4')
          .replaceAll('۵', '5')
          .replaceAll('۶', '6')
          .replaceAll('۷', '7')
          .replaceAll('۸', '8')
          .replaceAll('۹', '9')
          .replaceAll(',', '')
          .trim();
      return double.tryParse(normalized);
    }
    return null;
  }
}

class TobankSeekBarParser extends StacParser<TobankSeekBarModel> {
  const TobankSeekBarParser();

  @override
  String get type => 'tobankSeekBar';

  @override
  TobankSeekBarModel getModel(Map<String, dynamic> json) =>
      TobankSeekBarModel.fromJson(json);

  @override
  Widget parse(BuildContext context, TobankSeekBarModel model) {
    return _TobankSeekBarWidget(model: model);
  }
}

class _TobankSeekBarWidget extends StatefulWidget {
  const _TobankSeekBarWidget({required this.model});

  final TobankSeekBarModel model;

  @override
  State<_TobankSeekBarWidget> createState() => _TobankSeekBarWidgetState();
}

class _TobankSeekBarWidgetState extends State<_TobankSeekBarWidget> {
  late double _value;
  StacFormScope? _formScope;

  @override
  void initState() {
    super.initState();
    _value = widget.model.initialValue.clamp(
      widget.model.min,
      widget.model.max,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _formScope = StacFormScope.of(context);
    _syncValueToForm(_value);
  }

  void _syncValueToForm(double value) {
    if (widget.model.id == null) return;
    _formScope?.formData[widget.model.id!] = value;
  }

  void _runOnChangedAfterFrame() {
    final onChanged = widget.model.onChanged;
    if (onChanged == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Stac.onCallFromJson(onChanged, context);
    });
  }

  int _extractInt(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    final raw = value.toString();
    final normalized = raw
        .replaceAll('۰', '0')
        .replaceAll('۱', '1')
        .replaceAll('۲', '2')
        .replaceAll('۳', '3')
        .replaceAll('۴', '4')
        .replaceAll('۵', '5')
        .replaceAll('۶', '6')
        .replaceAll('۷', '7')
        .replaceAll('۸', '8')
        .replaceAll('۹', '9')
        .replaceAll(RegExp(r'[^0-9]'), '');
    if (normalized.isEmpty) return 0;
    return int.tryParse(normalized) ?? 0;
  }

  String _toPersianDigits(String input) {
    return input
        .replaceAll('0', '۰')
        .replaceAll('1', '۱')
        .replaceAll('2', '۲')
        .replaceAll('3', '۳')
        .replaceAll('4', '۴')
        .replaceAll('5', '۵')
        .replaceAll('6', '۶')
        .replaceAll('7', '۷')
        .replaceAll('8', '۸')
        .replaceAll('9', '۹');
  }

  String _formatWithComma(int value) {
    final digits = value.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      final posFromEnd = digits.length - i;
      buffer.write(digits[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) {
        buffer.write(',');
      }
    }
    return buffer.toString();
  }

  void _updateComputedAmount(double countValue) {
    final perInstallmentKey = widget.model.perInstallmentAmountKey;
    final destinationKey = widget.model.computedAmountDestinationKey;
    if (perInstallmentKey == null || destinationKey == null) return;

    final perInstallmentRaw = StacRegistry.instance.getValue(perInstallmentKey);
    final perInstallmentAmount = _extractInt(perInstallmentRaw);
    final count = countValue.round();
    final payable = perInstallmentAmount * count;
    final formatted = _toPersianDigits(_formatWithComma(payable));
    StacRegistry.instance.setValue(destinationKey, formatted);
    RegistryNotifier.instance.notify();
  }

  Color? _parseColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) return null;
    if (colorString.startsWith('{{') && colorString.endsWith('}}')) {
      final key = colorString.substring(2, colorString.length - 2).trim();
      final value = StacRegistry.instance.getValue(key);
      if (value is Color) return value;
      if (value is String) return _hexToColor(value);
      return null;
    }
    return _hexToColor(colorString);
  }

  Color? _hexToColor(String hex) {
    final cleaned = hex.replaceAll('#', '').trim();
    if (cleaned.isEmpty) return null;
    final normalized = cleaned.length == 6 ? 'FF$cleaned' : cleaned;
    if (normalized.length != 8) return null;
    return Color(int.parse(normalized, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight:
            widget.model.activeTrackHeight >= widget.model.inactiveTrackHeight
            ? widget.model.activeTrackHeight
            : widget.model.inactiveTrackHeight,
        thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: widget.model.thumbSize / 2,
        ),
      ),
      child: Slider(
        value: _value,
        min: widget.model.min,
        max: widget.model.max,
        activeColor: _parseColor(widget.model.activeTrackColor),
        inactiveColor: _parseColor(widget.model.inactiveTrackColor),
        thumbColor: _parseColor(widget.model.thumbColor),
        onChanged: (newValue) {
          final snappedValue = newValue.roundToDouble();
          setState(() {
            _value = snappedValue;
          });
          _syncValueToForm(snappedValue);
          _updateComputedAmount(snappedValue);
          _runOnChangedAfterFrame();
        },
      ),
    );
  }
}

void registerTobankSeekBarParser() {
  CustomComponentRegistry.instance.registerWidget(const TobankSeekBarParser());
}
