import 'package:flutter/foundation.dart';

/// Notifies listeners when the StacRegistry values change.
class RegistryNotifier {
  RegistryNotifier._internal();

  static final RegistryNotifier _instance = RegistryNotifier._internal();

  static RegistryNotifier get instance => _instance;

  final ValueNotifier<int> _version = ValueNotifier<int>(0);

  ValueListenable<int> get listenable => _version;

  void notify() {
    _version.value++;
  }
}
