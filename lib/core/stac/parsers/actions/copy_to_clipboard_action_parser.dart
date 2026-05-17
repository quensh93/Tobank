import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stac/stac.dart';
import 'package:tobank_sdui/core/bootstrap/app_root.dart';

import '../../../helpers/log_category.dart';
import '../../../helpers/logger.dart';

class CopyToClipboardActionModel {
  final String? text;
  final String? valueKey;
  final String? successMessage;
  final int? duration;

  const CopyToClipboardActionModel({
    this.text,
    this.valueKey,
    this.successMessage,
    this.duration,
  });

  factory CopyToClipboardActionModel.fromJson(Map<String, dynamic> json) {
    return CopyToClipboardActionModel(
      text: json['text'] as String?,
      valueKey: json['valueKey'] as String?,
      successMessage: json['successMessage'] as String?,
      duration: json['duration'] as int?,
    );
  }
}

class CopyToClipboardActionParser
    extends StacActionParser<CopyToClipboardActionModel> {
  const CopyToClipboardActionParser();
  static OverlayEntry? _activeOverlayEntry;

  @override
  String get actionType => 'copyToClipboard';

  @override
  CopyToClipboardActionModel getModel(Map<String, dynamic> json) {
    return CopyToClipboardActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    CopyToClipboardActionModel model,
  ) {
    final resolvedText = _resolveText(model.text, model.valueKey);
    AppLogger.dc(
      LogCategory.stacAction,
      'copyToClipboard: trigger (valueKey=${model.valueKey}, hasText=${(model.text ?? '').isNotEmpty})',
    );
    if (resolvedText.isEmpty) {
      AppLogger.wc(
        LogCategory.stacAction,
        'copyToClipboard: resolved text is empty, skipping',
      );
      return null;
    }

    Clipboard.setData(ClipboardData(text: resolvedText));
    AppLogger.dc(
      LogCategory.stacAction,
      'copyToClipboard: copied ${resolvedText.length} chars',
    );

    final fallbackMessage = _resolveText(
      '{{appStrings.current.copied_to_clipboard}}',
      null,
    );
    final message =
        (model.successMessage != null &&
            model.successMessage!.trim().isNotEmpty)
        ? _resolveText(model.successMessage, null)
        : (fallbackMessage.isNotEmpty
              ? fallbackMessage
              : 'مقدار در حافظه کپی شد');

    final rootContext = AppRoot.mainAppNavigatorKey.currentContext;
    final targetContext = rootContext ?? (context.mounted ? context : null);

    if (targetContext != null) {
      _showOverlaySnackBar(
        targetContext,
        message: message,
        durationMs: model.duration ?? 2500,
      );
      AppLogger.dc(
        LogCategory.stacAction,
        'copyToClipboard: snackbar shown (overlay)',
      );
    } else {
      AppLogger.wc(
        LogCategory.stacAction,
        'copyToClipboard: no context found for snackbar overlay',
      );
    }
    return null;
  }

  void _showOverlaySnackBar(
    BuildContext context, {
    required String message,
    required int durationMs,
  }) {
    _activeOverlayEntry?.remove();
    _activeOverlayEntry = null;

    final overlay =
        AppRoot.mainAppNavigatorKey.currentState?.overlay ??
        Overlay.maybeOf(context, rootOverlay: true) ??
        Overlay.maybeOf(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF1D2939) : const Color(0xFFFFFFFF);
    final txt = isDark ? const Color(0xFFD0D5DD) : const Color(0xFF475467);
    final border = isDark
        ? const Color(0xFFD0D7DD).withValues(alpha: 0.55)
        : const Color(0xFF475467).withValues(alpha: 0.35);

    if (overlay == null) {
      final messenger = ScaffoldMessenger.maybeOf(context);
      if (messenger != null) {
        messenger.hideCurrentSnackBar();
        messenger.showSnackBar(
          SnackBar(
            content: Text(
              message,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: txt,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            duration: Duration(milliseconds: durationMs),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
      }
      return;
    }

    final entry = OverlayEntry(
      builder: (_) => Positioned(
        left: 16,
        right: 16,
        bottom: 16,
        child: Material(
          color: Colors.transparent,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: border, width: 1),
              ),
              child: Text(
                message,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: txt,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    _activeOverlayEntry = entry;

    Future.delayed(Duration(milliseconds: durationMs), () {
      if (_activeOverlayEntry == entry) {
        _activeOverlayEntry?.remove();
        _activeOverlayEntry = null;
      }
    });
  }

  String _resolveText(String? rawText, String? valueKey) {
    final textCandidate = _resolveTemplates(rawText?.trim() ?? '');
    if (textCandidate.isNotEmpty) return textCandidate;

    final key = valueKey?.trim();
    if (key == null || key.isEmpty) return '';
    final value = StacRegistry.instance.getValue(key);
    return value?.toString().trim() ?? '';
  }

  String _resolveTemplates(String text) {
    if (text.isEmpty) return '';

    var resolved = text;
    final stacOpenRegex = RegExp(r'__STAC_OPEN__([^}]+)\}\}');
    resolved = resolved.replaceAllMapped(stacOpenRegex, (match) {
      final expr = match.group(1)?.trim();
      if (expr == null || expr.isEmpty) return '';
      return _lookupRegistryValue(expr)?.toString() ?? '';
    });

    final mustacheRegex = RegExp(r'\{\{([^}]+)\}\}');
    resolved = resolved.replaceAllMapped(mustacheRegex, (match) {
      final expr = match.group(1)?.trim();
      if (expr == null || expr.isEmpty) return '';
      return _lookupRegistryValue(expr)?.toString() ?? '';
    });

    return resolved.trim();
  }

  dynamic _lookupRegistryValue(String path) {
    final registry = StacRegistry.instance;
    final direct = registry.getValue(path);
    if (direct != null) return direct;

    final normalizedPath = path.replaceAllMapped(
      RegExp(r'\[(\d+)\]'),
      (m) => '.${m.group(1)}',
    );
    final segments = normalizedPath
        .split('.')
        .where((segment) => segment.isNotEmpty)
        .toList();
    if (segments.isEmpty) return null;

    dynamic value = registry.getValue(segments.first);
    for (final segment in segments.skip(1)) {
      if (value is Map<String, dynamic>) {
        value = value[segment];
      } else if (value is Map) {
        value = value[segment];
      } else if (value is List) {
        final index = int.tryParse(segment);
        if (index == null || index < 0 || index >= value.length) return null;
        value = value[index];
      } else {
        return null;
      }
    }
    return value;
  }
}
