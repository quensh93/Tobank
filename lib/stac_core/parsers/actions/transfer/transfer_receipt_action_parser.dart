import 'dart:async';
import 'dart:ui' as ui;
import 'package:stac/stac.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/helpers/logger.dart';
import '../../../registry/custom_component_registry.dart';
import '../../../registry/receipt_boundary_registry.dart';
import '../../../utils/web_file_download_stub.dart'
    if (dart.library.html) '../../../utils/web_file_download_web.dart';

class TransferReceiptActionModel {
  final String mode;
  final String? title;
  final double pixelRatio;
  final String boundaryKey;

  const TransferReceiptActionModel({
    required this.mode,
    this.title,
    this.pixelRatio = 3,
    this.boundaryKey = 'transferReceiptBoundary',
  });

  factory TransferReceiptActionModel.fromJson(Map<String, dynamic> json) {
    return TransferReceiptActionModel(
      mode: (json['mode'] as String?) ?? 'shareText',
      title: json['title'] as String?,
      pixelRatio: (json['pixelRatio'] as num?)?.toDouble() ?? 3,
      boundaryKey: (json['boundaryKey'] as String?)?.trim().isNotEmpty == true
          ? (json['boundaryKey'] as String).trim()
          : 'transferReceiptBoundary',
    );
  }
}

class TransferReceiptActionParser
    extends StacActionParser<TransferReceiptActionModel> {
  const TransferReceiptActionParser();

  @override
  String get actionType => 'transferReceipt';

  @override
  TransferReceiptActionModel getModel(Map<String, dynamic> json) =>
      TransferReceiptActionModel.fromJson(json);

  @override
  FutureOr onCall(
    BuildContext context,
    TransferReceiptActionModel model,
  ) async {
    try {
      switch (model.mode) {
        case 'shareImage':
          await _shareImage(context, model);
          return null;
        case 'shareText':
        default:
          await _shareText(context, model);
          return null;
      }
    } catch (e) {
      AppLogger.e('transferReceipt action failed: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('خطا در انجام عملیات رسید')),
        );
      }
      return null;
    }
  }

  Future<void> _shareText(
    BuildContext context,
    TransferReceiptActionModel model,
  ) async {
    final transferType = _value('transferApiTransferTypeTitle', '-');
    final amount = _value('transferApiAmountRaw', '0');
    final destinationIban = _value('transferApiDestinationIban', '-');
    final destinationName = _value('transferApiDestinationName', '-');

    final text = StringBuffer()
      ..writeln('رسید انتقال وجه')
      ..writeln('نوع انتقال: $transferType')
      ..writeln('مبلغ انتقال: $amount ریال')
      ..writeln('شماره سپرده مبدا: ۱۱۰.۹۹۲۲.۱۷۹۳۸۵۸.۱')
      ..writeln('شماره شبا مقصد: IR$destinationIban')
      ..writeln('صاحب سپرده مقصد: $destinationName')
      ..writeln('www.tobank.ir');

    await SharePlus.instance.share(
      ShareParams(text: text.toString(), subject: model.title ?? 'رسید تراکنش'),
    );
  }

  Future<void> _shareImage(
    BuildContext context,
    TransferReceiptActionModel model,
  ) async {
    final boundary = await _waitForReceiptBoundary(model.boundaryKey);
    final ui.Image image = await boundary.toImage(pixelRatio: model.pixelRatio);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw Exception('failed to capture image bytes');
    }
    final bytes = byteData.buffer.asUint8List();
    final filename =
        'transfer_receipt_${DateTime.now().millisecondsSinceEpoch}.png';

    if (kIsWeb) {
      await downloadFileFromBytes(
        bytes: bytes,
        fileName: filename,
        mimeType: 'image/png',
      );
      return;
    }

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile.fromData(bytes, name: filename, mimeType: 'image/png')],
        subject: model.title ?? 'رسید تراکنش',
      ),
    );
  }

  Future<RenderRepaintBoundary> _waitForReceiptBoundary(
    String boundaryKey,
  ) async {
    const maxAttempts = 8;
    for (var i = 0; i < maxAttempts; i++) {
      // Wait for the next frame to ensure the boundary is laid out and painted.
      await WidgetsBinding.instance.endOfFrame;

      final boundaryGlobalKey = ReceiptBoundaryRegistry.instance.get(
        boundaryKey,
      );
      final boundaryContext = boundaryGlobalKey?.currentContext;
      final renderObject = boundaryContext?.findRenderObject();

      if (renderObject is RenderRepaintBoundary &&
          !renderObject.debugNeedsPaint) {
        return renderObject;
      }
    }
    throw Exception('receipt boundary is not ready for capture');
  }

  String _value(String key, String fallback) {
    final v = StacRegistry.instance.getValue(key);
    if (v == null) return fallback;
    final s = v.toString().trim();
    return s.isEmpty ? fallback : s;
  }
}

void registerTransferReceiptActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const TransferReceiptActionParser(),
  );
}
