import 'package:flutter/widgets.dart';

class ReceiptBoundaryRegistry {
  ReceiptBoundaryRegistry._();

  static final ReceiptBoundaryRegistry instance = ReceiptBoundaryRegistry._();

  final Map<String, GlobalKey> _keys = <String, GlobalKey>{};

  GlobalKey getOrCreate(String key) {
    return _keys.putIfAbsent(key, () => GlobalKey(debugLabel: key));
  }

  GlobalKey? get(String key) => _keys[key];
}
