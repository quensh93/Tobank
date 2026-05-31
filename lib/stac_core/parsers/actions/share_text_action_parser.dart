import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stac/stac.dart';

import '../../../core/helpers/log_category.dart';
import '../../../core/helpers/logger.dart';

class ShareTextActionModel {
  final String? text;
  final String? valueKey;
  final String? subject;

  const ShareTextActionModel({this.text, this.valueKey, this.subject});

  factory ShareTextActionModel.fromJson(Map<String, dynamic> json) {
    return ShareTextActionModel(
      text: json['text'] as String?,
      valueKey: json['valueKey'] as String?,
      subject: json['subject'] as String?,
    );
  }
}

class ShareTextActionParser extends StacActionParser<ShareTextActionModel> {
  const ShareTextActionParser();

  @override
  String get actionType => 'shareText';

  @override
  ShareTextActionModel getModel(Map<String, dynamic> json) {
    return ShareTextActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShareTextActionModel model,
  ) async {
    final resolvedText = _resolveText(model.text, model.valueKey);
    AppLogger.dc(
      LogCategory.stacAction,
      'shareText: trigger (valueKey=${model.valueKey}, hasText=${(model.text ?? '').isNotEmpty})',
    );
    if (resolvedText.isEmpty) {
      AppLogger.wc(
        LogCategory.stacAction,
        'shareText: resolved text is empty, skipping',
      );
      return null;
    }

    await SharePlus.instance.share(
      ShareParams(
        text: resolvedText,
        subject: (model.subject?.trim().isNotEmpty ?? false)
            ? model.subject!.trim()
            : '',
      ),
    );
    AppLogger.dc(LogCategory.stacAction, 'shareText: native share opened');
    return null;
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
