import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stac/stac.dart';

import '../../../../core/helpers/logger.dart';

class SaveFileActionModel {
  final String fileName;
  final String content;
  final String? registryKey;
  final bool isBase64;

  SaveFileActionModel({
    required this.fileName,
    required this.content,
    this.registryKey,
    this.isBase64 = true,
  });

  factory SaveFileActionModel.fromJson(Map<String, dynamic> json) {
    return SaveFileActionModel(
      fileName: json['fileName'] ?? 'output.txt',
      content: json['content'] ?? '',
      registryKey: json['registryKey'] as String?,
      isBase64: json['isBase64'] ?? true,
    );
  }
}

class SaveFileActionParser extends StacActionParser<SaveFileActionModel> {
  const SaveFileActionParser();

  @override
  String get actionType => 'saveFile';

  @override
  SaveFileActionModel getModel(Map<String, dynamic> json) =>
      SaveFileActionModel.fromJson(json);

  @override
  FutureOr onCall(BuildContext context, SaveFileActionModel model) async {
    try {
      // Resolve content from registry or template
      String content = '';

      if (model.registryKey != null) {
        final registryValue = StacRegistry.instance.getValue(
          model.registryKey!,
        );
        if (registryValue is String && registryValue.isNotEmpty) {
          content = registryValue;
        }
      }

      if (content.isEmpty) {
        content = _resolveTemplates(model.content);
      }

      if (content.isEmpty) {
        AppLogger.e('SaveFile: No content to save');
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('No content to save')));
        }
        return null;
      }

      // Save to the device's default Downloads folder (visible in Files app)
      Directory? directory = await getDownloadsDirectory();
      directory ??= await getApplicationDocumentsDirectory();

      final path = '${directory.path}/${model.fileName}';
      final file = File(path);

      if (model.isBase64) {
        // Strip data URI prefix if present
        if (content.startsWith('data:')) {
          final commaIndex = content.indexOf(',');
          if (commaIndex != -1) {
            content = content.substring(commaIndex + 1);
          }
        }

        // Decode base64 and write as bytes
        final cleanBase64 = content.replaceAll(RegExp(r'\s+'), '');
        final Uint8List bytes = base64Decode(cleanBase64);
        await file.writeAsBytes(bytes);
        AppLogger.i('SaveFile: Saved ${bytes.length} bytes to: $path');
      } else {
        // Write as plain text
        await file.writeAsString(content);
        AppLogger.i('SaveFile: Saved text to: $path');
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فایل ذخیره شد: ${model.fileName}'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      AppLogger.e('SaveFile: Error saving file: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving file: $e')));
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
