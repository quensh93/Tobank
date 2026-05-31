import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stac/stac.dart';

import '../../../../core/helpers/logger.dart';

class ShareFileActionModel {
  final String fileName;
  final String content;
  final String? registryKey;
  final String mimeType;

  ShareFileActionModel({
    required this.fileName,
    required this.content,
    this.registryKey,
    this.mimeType = 'application/pdf',
  });

  factory ShareFileActionModel.fromJson(Map<String, dynamic> json) {
    return ShareFileActionModel(
      fileName: json['fileName'] ?? 'document.pdf',
      content: json['content'] ?? '',
      registryKey: json['registryKey'] as String?,
      mimeType: json['mimeType'] ?? 'application/pdf',
    );
  }
}

/// STAC action parser for sharing files.
///
/// Decodes base64 content → writes to a temp file → shares via share_plus.
///
/// Usage:
/// ```json
/// {
///   "actionType": "shareFile",
///   "fileName": "promissory.pdf",
///   "registryKey": "form.serverSignedPdf",
///   "content": "{{form.serverSignedPdf}}",
///   "mimeType": "application/pdf"
/// }
/// ```
class ShareFileActionParser extends StacActionParser<ShareFileActionModel> {
  const ShareFileActionParser();

  @override
  String get actionType => 'shareFile';

  @override
  ShareFileActionModel getModel(Map<String, dynamic> json) =>
      ShareFileActionModel.fromJson(json);

  @override
  FutureOr onCall(BuildContext context, ShareFileActionModel model) async {
    try {
      // Resolve the base64 content
      String base64String = '';

      // 1. Try registry key first
      if (model.registryKey != null) {
        final registryValue = StacRegistry.instance.getValue(
          model.registryKey!,
        );
        if (registryValue is String && registryValue.isNotEmpty) {
          base64String = registryValue;
        }
      }

      // 2. Fall back to content field
      if (base64String.isEmpty) {
        base64String = _resolveTemplates(model.content);
      }

      if (base64String.isEmpty) {
        AppLogger.e('ShareFile: No content to share');
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('No file to share')));
        }
        return null;
      }

      // Strip data URI prefix if present
      if (base64String.startsWith('data:')) {
        final commaIndex = base64String.indexOf(',');
        if (commaIndex != -1) {
          base64String = base64String.substring(commaIndex + 1);
        }
      }

      // Clean up and decode base64
      final cleanBase64 = base64String.replaceAll(RegExp(r'\s+'), '');
      final Uint8List fileBytes = base64Decode(cleanBase64);

      AppLogger.d('ShareFile: Decoded ${fileBytes.length} bytes');

      // Write to temp file
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/${model.fileName}';
      final file = File(filePath);
      await file.writeAsBytes(fileBytes);

      AppLogger.d('ShareFile: Temp file written to $filePath');

      // Share the file
      final xFile = XFile(filePath, mimeType: model.mimeType);
      await SharePlus.instance.share(ShareParams(files: [xFile]));

      AppLogger.i('ShareFile: Share dialog opened');
    } catch (e) {
      AppLogger.e('ShareFile: Error sharing file: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error sharing file: $e')));
      }
    }
    return null;
  }

  String _resolveTemplates(String message) {
    if (!message.contains('{{') || !message.contains('}}')) return message;

    return message.replaceAllMapped(RegExp(r'\{\{([^}]+)\}\}'), (match) {
      final expr = match.group(1)?.trim();
      if (expr == null || expr.isEmpty) return match.group(0) ?? '';

      final value = StacRegistry.instance.getValue(expr);
      return value?.toString() ?? match.group(0) ?? '';
    });
  }
}
