import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

/// Notifies listeners when the StacRegistry values change.
class RegistryNotifier {
  RegistryNotifier._internal();

  static final RegistryNotifier _instance = RegistryNotifier._internal();

  static RegistryNotifier get instance => _instance;

  final ValueNotifier<int> _version = ValueNotifier<int>(0);
  bool _hasScheduledNotify = false;
  int _pendingIncrements = 0;

  ValueListenable<int> get listenable => _version;

  void notify() {
    final schedulerPhase = SchedulerBinding.instance.schedulerPhase;
    final shouldDefer = schedulerPhase == SchedulerPhase.persistentCallbacks;

    if (!shouldDefer) {
      _version.value++;
      return;
    }

    _pendingIncrements++;
    if (_hasScheduledNotify) return;

    _hasScheduledNotify = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _hasScheduledNotify = false;
      if (_pendingIncrements == 0) return;

      final increments = _pendingIncrements;
      _pendingIncrements = 0;
      _version.value += increments;
    });
  }
}
