import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stac/stac.dart';

import '../../../helpers/logger.dart';

class SaveFileActionModel {
  final String fileName;
  final String content;

  SaveFileActionModel({required this.fileName, required this.content});

  factory SaveFileActionModel.fromJson(Map<String, dynamic> json) {
    return SaveFileActionModel(
      fileName: json['fileName'] ?? 'output.txt',
      content: json['content'] ?? '',
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
      // Use Downloads folder on Android, fall back to documents on other platforms
      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getDownloadsDirectory();
      }
      directory ??= await getApplicationDocumentsDirectory();

      final path = '${directory.path}/${model.fileName}';
      final file = File(path);

      final content = _resolveTemplates(model.content);

      await file.writeAsString(content);

      AppLogger.i('File saved to: $path');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File saved: $path'),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      AppLogger.e('Error saving file: $e');
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
