import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../registry/registry_notifier.dart';
import '../../../core/helpers/logger.dart';

/// Model for the pdfPreview widget.
class PdfPreviewModel {
  final String? src;
  final String? registryKey;
  final double? width;
  final double? height;

  const PdfPreviewModel({this.src, this.registryKey, this.width, this.height});

  factory PdfPreviewModel.fromJson(Map<String, dynamic> json) {
    return PdfPreviewModel(
      src: json['src'] as String?,
      registryKey: json['registryKey'] as String?,
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
    );
  }
}

/// STAC parser for displaying PDF files from base64 data.
///
/// Usage:
/// ```json
/// {
///   "type": "pdfPreview",
///   "src": "{{serverSignedPdf}}",
///   "registryKey": "serverSignedPdf",
///   "width": 999999,
///   "height": 500
/// }
/// ```
class PdfPreviewParser extends StacParser<PdfPreviewModel> {
  const PdfPreviewParser();

  @override
  String get type => 'pdfPreview';

  @override
  PdfPreviewModel getModel(Map<String, dynamic> json) {
    return PdfPreviewModel.fromJson(json);
  }

  @override
  Widget parse(BuildContext context, PdfPreviewModel model) {
    return ValueListenableBuilder<int>(
      valueListenable: RegistryNotifier.instance.listenable,
      builder: (context, _, _) {
        String? base64String;

        // 1. Try registry key first (most reliable for large data)
        if (model.registryKey != null) {
          final registryValue = StacRegistry.instance.getValue(
            model.registryKey!,
          );
          AppLogger.d(
            'PdfPreview: registryKey=${model.registryKey}, '
            'valueType=${registryValue?.runtimeType}, '
            'hasValue=${registryValue != null}',
          );
          if (registryValue is String && registryValue.isNotEmpty) {
            // Strip data URI prefix if present
            if (registryValue.startsWith('data:')) {
              final commaIndex = registryValue.indexOf(',');
              if (commaIndex != -1) {
                base64String = registryValue.substring(commaIndex + 1);
              }
            } else {
              base64String = registryValue;
            }
          }
        }

        // 2. Fall back to src (may have been resolved by STAC template engine)
        if (base64String == null && model.src != null) {
          final src = model.src!;
          AppLogger.d(
            'PdfPreview: Trying src, length=${src.length}, '
            'startsWithData=${src.startsWith('data:')}, '
            'startsWithTemplate=${src.startsWith('{{')}',
          );
          if (src.startsWith('data:')) {
            final commaIndex = src.indexOf(',');
            if (commaIndex != -1) {
              base64String = src.substring(commaIndex + 1);
            }
          } else if (!src.startsWith('{{') && src.length > 10) {
            // Direct base64 string (not an unresolved template)
            base64String = src;
          }
        }

        AppLogger.d(
          'PdfPreview: base64String found=${base64String != null}, '
          'length=${base64String?.length ?? 0}',
        );

        // If no data, show placeholder
        if (base64String == null || base64String.isEmpty) {
          return SizedBox(
            width: model.width,
            height: model.height ?? 400,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.picture_as_pdf, size: 48, color: Colors.grey),
                  SizedBox(height: 8),
                  Text(
                    'PDF data not available',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        }

        // Decode base64 to bytes
        try {
          // Clean up base64 string (remove whitespace/newlines)
          final cleanBase64 = base64String.replaceAll(RegExp(r'\s+'), '');
          final Uint8List pdfBytes = base64Decode(cleanBase64);
          AppLogger.d(
            'PdfPreview: Decoded PDF, ${pdfBytes.length} bytes, '
            'first4=${pdfBytes.length >= 4 ? pdfBytes.sublist(0, 4) : pdfBytes}',
          );

          // Check if it looks like a valid PDF (starts with %PDF)
          if (pdfBytes.length >= 4) {
            final header = String.fromCharCodes(pdfBytes.sublist(0, 4));
            AppLogger.d('PdfPreview: File header: "$header"');
          }

          return SizedBox(
            width: model.width,
            height: model.height ?? 500,
            child: SfPdfViewer.memory(
              pdfBytes,
              canShowScrollHead: false,
              canShowScrollStatus: false,
              enableDoubleTapZooming: true,
              onDocumentLoadFailed: (details) {
                AppLogger.e(
                  'PdfPreview: Document load failed: '
                  '${details.error}, ${details.description}',
                );
              },
              onDocumentLoaded: (details) {
                AppLogger.d(
                  'PdfPreview: Document loaded, '
                  '${details.document.pages.count} pages',
                );
              },
            ),
          );
        } catch (e, stackTrace) {
          AppLogger.e('PdfPreview: Failed to decode base64: $e');
          AppLogger.e('PdfPreview: Stack: $stackTrace');
          return SizedBox(
            width: model.width,
            height: model.height ?? 400,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 8),
                  Text(
                    'Error loading PDF:\n$e',
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
