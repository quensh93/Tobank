import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stac/stac.dart';

class OtpCountdownButtonModel {
  const OtpCountdownButtonModel({
    this.initialSeconds = 120,
    this.retryLabel = 'تلاش مجدد',
    this.requestLabel = 'دریافت رمز پویا',
    this.startOnTap = false,
    this.showIcon = true,
    this.iconAsset = 'assets/icons/ic_clock.svg',
    this.onStart,
    this.onRetry,
    this.borderColor,
    this.expiredBorderColor,
    this.countdownTextColor,
    this.retryTextColor,
    this.backgroundColor,
    this.height = 60,
    this.minWidth = 132,
  });

  final int initialSeconds;
  final String retryLabel;
  final String requestLabel;
  final bool startOnTap;
  final bool showIcon;
  final String iconAsset;
  final Map<String, dynamic>? onStart;
  final Map<String, dynamic>? onRetry;
  final String? borderColor;
  final String? expiredBorderColor;
  final String? countdownTextColor;
  final String? retryTextColor;
  final String? backgroundColor;
  final double height;
  final double minWidth;

  factory OtpCountdownButtonModel.fromJson(Map<String, dynamic> json) {
    return OtpCountdownButtonModel(
      initialSeconds: json['initialSeconds'] as int? ?? 120,
      retryLabel: json['retryLabel'] as String? ?? 'تلاش مجدد',
      requestLabel: json['requestLabel'] as String? ?? 'دریافت رمز پویا',
      startOnTap: json['startOnTap'] as bool? ?? false,
      showIcon: json['showIcon'] as bool? ?? true,
      iconAsset: json['iconAsset'] as String? ?? 'assets/icons/ic_clock.svg',
      onStart: json['onStart'] as Map<String, dynamic>?,
      onRetry: json['onRetry'] as Map<String, dynamic>?,
      borderColor: json['borderColor'] as String?,
      countdownTextColor: json['countdownTextColor'] as String?,
      retryTextColor: json['retryTextColor'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
      height: (json['height'] as num?)?.toDouble() ?? 60,
      minWidth: (json['minWidth'] as num?)?.toDouble() ?? 132,
      expiredBorderColor: json['expiredBorderColor'] as String?,
    );
  }
}

class OtpCountdownButtonParser extends StacParser<OtpCountdownButtonModel> {
  const OtpCountdownButtonParser();

  @override
  String get type => 'otpCountdownButton';

  @override
  OtpCountdownButtonModel getModel(Map<String, dynamic> json) {
    return OtpCountdownButtonModel.fromJson(json);
  }

  @override
  Widget parse(BuildContext context, OtpCountdownButtonModel model) {
    return _OtpCountdownButton(model: model);
  }
}

class _OtpCountdownButton extends StatefulWidget {
  const _OtpCountdownButton({required this.model});

  final OtpCountdownButtonModel model;

  @override
  State<_OtpCountdownButton> createState() => _OtpCountdownButtonState();
}

class _OtpCountdownButtonState extends State<_OtpCountdownButton> {
  Timer? _timer;
  late int _remainingSeconds;
  late bool _hasStarted;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.model.initialSeconds;
    _hasStarted = !widget.model.startOnTap;
    if (_hasStarted) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_remainingSeconds <= 0) {
        timer.cancel();
        return;
      }

      setState(() {
        _remainingSeconds -= 1;
      });
    });
  }

  Future<void> _handleStart() async {
    if (_hasStarted) return;

    setState(() {
      _hasStarted = true;
      _remainingSeconds = widget.model.initialSeconds;
    });
    _startTimer();

    if (widget.model.onStart != null) {
      await Stac.onCallFromJson(widget.model.onStart!, context);
      return;
    }
    if (widget.model.onRetry != null) {
      await Stac.onCallFromJson(widget.model.onRetry!, context);
    }
  }

  Future<void> _handleRetry() async {
    if (_remainingSeconds > 0) return;

    setState(() {
      _remainingSeconds = widget.model.initialSeconds;
    });
    _startTimer();

    if (widget.model.onRetry != null) {
      await Stac.onCallFromJson(widget.model.onRetry!, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWaitingToStart = widget.model.startOnTap && !_hasStarted;
    final isExpired = _remainingSeconds <= 0;
    final borderColor =
        _parseColor(widget.model.borderColor) ??
        Theme.of(context).colorScheme.outline;
    final expiredBorderColor =
        _parseColor(widget.model.expiredBorderColor) ??
        Theme.of(context).colorScheme.outline;
    final countdownTextColor =
        _parseColor(widget.model.countdownTextColor) ??
        Theme.of(context).colorScheme.onSurfaceVariant;
    final retryTextColor =
        _parseColor(widget.model.retryTextColor) ??
        Theme.of(context).colorScheme.primary;
    final backgroundColor =
        _parseColor(widget.model.backgroundColor) ?? Colors.transparent;

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: widget.model.minWidth),
      child: SizedBox(
        height: widget.model.height,
        child: GestureDetector(
          onTap: isWaitingToStart
              ? _handleStart
              : isExpired
              ? _handleRetry
              : null,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: isExpired ? expiredBorderColor : borderColor,
              ),
              borderRadius: BorderRadius.circular(12),
              color: backgroundColor,
            ),
            child: isWaitingToStart
                ? Center(
                    child: Text(
                      widget.model.requestLabel,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: retryTextColor,
                      ),
                    ),
                  )
                : isExpired
                ? Center(
                    child: Text(
                      widget.model.retryLabel,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: retryTextColor,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    textDirection: TextDirection.ltr,
                    children: [
                      if (widget.model.showIcon) ...[
                        _buildCountdownIcon(countdownTextColor),
                        const SizedBox(width: 8),
                      ],
                      SizedBox(
                        width: 43,
                        child: Text(
                          _formatDuration(_remainingSeconds),
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: countdownTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildCountdownIcon(Color countdownTextColor) {
    final iconAsset = widget.model.iconAsset;
    if (iconAsset.trim().isEmpty) {
      return const SizedBox.shrink();
    }
    final isSvg = iconAsset.toLowerCase().endsWith('.svg');

    if (isSvg) {
      return SvgPicture.asset(
        iconAsset,
        width: 22,
        height: 22,
        colorFilter: ColorFilter.mode(countdownTextColor, BlendMode.srcIn),
      );
    }

    return Image.asset(
      iconAsset,
      width: 22,
      height: 22,
      color: countdownTextColor,
      errorBuilder: (_, error, stackTrace) =>
          const SizedBox(width: 25, height: 25),
    );
  }

  String _formatDuration(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Color? _parseColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) return null;

    if (colorString.startsWith('{{') && colorString.endsWith('}}')) {
      final key = colorString.substring(2, colorString.length - 2);
      final value = StacRegistry.instance.getValue(key);
      if (value is String) {
        return _hexToColor(value);
      }
      if (value is Color) {
        return value;
      }
    }

    return _hexToColor(colorString);
  }

  Color? _hexToColor(String hex) {
    if (hex.isEmpty) return null;
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }
}
