import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_io/io.dart';

/// Utility for capturing and sharing/downloading images across platforms
abstract class ImageShareUtil {
  /// Captures a widget with the given globalKey and shares/downloads it
  static Future<void> captureAndShareWidget({
    required GlobalKey globalKey,
    double pixelRatio = 3.0,
    String fileName = 'image.png',
    String shareText = '',
  }) async {
    try {
      // Capture the widget as an image
      final RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: pixelRatio);
      final ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

      if (byteData == null) {
        throw Exception('Failed to capture image');
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();

      // Share/download based on platform
      await shareImageBytes(
        bytes: pngBytes,
        fileName: fileName,
        shareText: shareText,
      );
    } catch (e) {
      print('Error capturing and sharing image: $e');
      rethrow;
    }
  }

  /// Shares/downloads image bytes based on the current platform
  static Future<void> shareImageBytes({
    required Uint8List bytes,
    required String fileName,
    String shareText = '',
  }) async {
    try {
      if (kIsWeb) {
        // Web implementation
        _downloadBytesOnWeb(bytes, fileName);
      } else {
        // Mobile implementation
        final tempFile = await _createTempFile(fileName, bytes);

        if (Platform.isAndroid) {
          await Share.shareXFiles([XFile(tempFile.path)], text: shareText);
        } else {
          await Share.shareXFiles([XFile(tempFile.path)], subject: shareText);
        }
      }
    } catch (e) {
      print('Error sharing image: $e');
      rethrow;
    }
  }

  /// Download bytes as a file on web
  static void _downloadBytesOnWeb(Uint8List bytes, String fileName) {
    final blob = html.Blob([bytes], 'image/png');
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..style.display = 'none';

    html.document.body!.children.add(anchor);
    anchor.click();

    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  /// Create a temporary file for sharing on mobile
  static Future<File> _createTempFile(String fileName, Uint8List bytes) async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/$fileName';
    final file = File(path);
    await file.writeAsBytes(bytes);
    return file;
  }
}