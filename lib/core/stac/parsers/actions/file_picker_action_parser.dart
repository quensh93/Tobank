import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:stac/stac.dart';

import 'file_picker_action_model.dart';
import '../../registry/custom_component_registry.dart';
import '../../../helpers/log_category.dart';
import '../../../helpers/logger.dart';

/// File Picker Action Parser
///
/// A custom STAC action parser that handles file picking using file_picker package.
/// Supports different file types and handles platform differences (web vs desktop).
///
/// On web: Converts file bytes to base64 data URL for display
/// On desktop/mobile: Uses file path directly
class FilePickerActionParser extends StacActionParser<FilePickerActionModel> {
  const FilePickerActionParser();

  @override
  String get actionType => 'pickFile';

  @override
  FilePickerActionModel getModel(Map<String, dynamic> json) =>
      FilePickerActionModel.fromJson(json);

  @override
  FutureOr<void> onCall(
    BuildContext context,
    FilePickerActionModel model,
  ) async {
    AppLogger.dc(
      LogCategory.action,
      'FilePickerAction: Picking file with type=${model.fileType}, targetKey=${model.targetKey}',
    );

    try {
      // Determine file type
      final fileType = _getFileType(model.fileType);

      // Pick file
      final result = await FilePicker.platform.pickFiles(
        type: fileType,
        allowedExtensions: model.allowedExtensions,
        allowMultiple: model.allowMultiple,
        withData: true, // Always get bytes for web compatibility
      );

      if (result == null || result.files.isEmpty) {
        AppLogger.dc(
          LogCategory.action,
          'FilePickerAction: User cancelled file picker',
        );
        return;
      }

      final file = result.files.first;
      String? imageData;

      if (kIsWeb) {
        // On web, convert bytes to base64 data URL
        if (file.bytes != null) {
          final mimeType = _getMimeType(file.extension);
          final base64 = base64Encode(file.bytes!);
          imageData = 'data:$mimeType;base64,$base64';
          AppLogger.dc(
            LogCategory.action,
            'FilePickerAction: Web - Created base64 data URL (${file.bytes!.length} bytes)',
          );
        }
      } else {
        // On desktop/mobile, use file path
        imageData = file.path;
        AppLogger.dc(
          LogCategory.action,
          'FilePickerAction: Desktop/Mobile - Using file path: $imageData',
        );
      }

      if (imageData != null) {
        // Store in STAC state using setValue
        final setValueAction = {
          'actionType': 'setValue',
          'values': [
            {'key': model.targetKey, 'value': imageData},
            {'key': 'hasImage', 'value': true},
          ],
        };

        if (context.mounted) {
          await Stac.onCallFromJson(setValueAction, context);
          AppLogger.ic(
            LogCategory.action,
            'FilePickerAction: Stored image in state with key="${model.targetKey}"',
          );
        }
      }
    } catch (e, stack) {
      AppLogger.ec(
        LogCategory.action,
        'FilePickerAction: Error picking file: $e',
        e,
        stack,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطا در انتخاب فایل: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  FileType _getFileType(String type) {
    switch (type.toLowerCase()) {
      case 'image':
        return FileType.image;
      case 'video':
        return FileType.video;
      case 'audio':
        return FileType.audio;
      case 'media':
        return FileType.media;
      case 'custom':
        return FileType.custom;
      default:
        return FileType.any;
    }
  }

  String _getMimeType(String? extension) {
    if (extension == null) return 'application/octet-stream';

    switch (extension.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'bmp':
        return 'image/bmp';
      case 'svg':
        return 'image/svg+xml';
      default:
        return 'image/$extension';
    }
  }
}

/// Register the file picker action parser
void registerFilePickerActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const FilePickerActionParser(),
  );
  AppLogger.dc(LogCategory.action, 'Registered FilePickerActionParser');
}
