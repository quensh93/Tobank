import 'package:flutter/widgets.dart';
import 'package:stac/stac.dart';

import '../../registry/receipt_boundary_registry.dart';

class ReceiptRepaintBoundaryModel {
  final String boundaryKey;
  final Map<String, dynamic>? child;

  const ReceiptRepaintBoundaryModel({required this.boundaryKey, this.child});

  factory ReceiptRepaintBoundaryModel.fromJson(Map<String, dynamic> json) {
    return ReceiptRepaintBoundaryModel(
      boundaryKey: (json['boundaryKey'] as String?)?.trim().isNotEmpty == true
          ? (json['boundaryKey'] as String).trim()
          : 'transferReceiptBoundary',
      child: json['child'] is Map<String, dynamic>
          ? json['child'] as Map<String, dynamic>
          : json['child'] is Map
          ? Map<String, dynamic>.from(json['child'] as Map)
          : null,
    );
  }
}

class ReceiptRepaintBoundaryParser
    extends StacParser<ReceiptRepaintBoundaryModel> {
  const ReceiptRepaintBoundaryParser();

  @override
  String get type => 'receiptRepaintBoundary';

  @override
  ReceiptRepaintBoundaryModel getModel(Map<String, dynamic> json) {
    return ReceiptRepaintBoundaryModel.fromJson(json);
  }

  @override
  Widget parse(BuildContext context, ReceiptRepaintBoundaryModel model) {
    final key = ReceiptBoundaryRegistry.instance.getOrCreate(model.boundaryKey);
    final child = model.child != null
        ? Stac.fromJson(model.child!, context) ?? const SizedBox.shrink()
        : const SizedBox.shrink();
    return RepaintBoundary(key: key, child: child);
  }
}
