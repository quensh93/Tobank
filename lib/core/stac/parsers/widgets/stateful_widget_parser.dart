import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../../helpers/logger.dart';
import '../../../helpers/log_category.dart';
import '../../utils/registry_notifier.dart';
import 'stateful_widget_model.dart';

class StatefulWidgetParser extends StacParser<StatefulWidgetModel> {
  const StatefulWidgetParser();

  @override
  String get type => 'stateful';

  @override
  StatefulWidgetModel getModel(Map<String, dynamic> json) {
    return StatefulWidgetModel.fromJson(json);
  }

  @override
  Widget parse(BuildContext context, StatefulWidgetModel model) {
    return _StatefulWidgetWrapper(model: model);
  }
}

class StateFullWidgetParser extends StatefulWidgetParser {
  const StateFullWidgetParser();

  @override
  String get type => 'stateFull';
}

class _StatefulWidgetWrapper extends StatefulWidget {
  final StatefulWidgetModel model;

  const _StatefulWidgetWrapper({required this.model});

  @override
  _StatefulWidgetWrapperState createState() => _StatefulWidgetWrapperState();
}

class _StatefulWidgetWrapperState extends State<_StatefulWidgetWrapper>
    with WidgetsBindingObserver {
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _isMounted = true;
    // Listen for registry changes to trigger rebuilds
    RegistryNotifier.instance.listenable.addListener(_onRegistryChanged);
    _executeAction(widget.model.onInit, 'onInit');
  }

  void _onRegistryChanged() {
    if (_isMounted && mounted) {
      AppLogger.dc(
        LogCategory.state,
        'StatefulWidget: Registry changed, triggering rebuild',
      );
      final selectedImage = StacRegistry.instance.getValue('selectedImage');
      AppLogger.dc(
        LogCategory.state,
        'StatefulWidget: selectedImage value exists=${selectedImage != null && selectedImage.toString().isNotEmpty}',
      );
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isMounted) {
      _executeAction(
        widget.model.onDependenciesChanged,
        'onDependenciesChanged',
      );
    }
  }

  @override
  void didUpdateWidget(covariant _StatefulWidgetWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isMounted) {
      _executeAction(widget.model.onWidgetUpdated, 'onWidgetUpdated');
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (_isMounted) {
      _executeAction(widget.model.onReassemble, 'onReassemble');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_isMounted) return;

    switch (state) {
      case AppLifecycleState.resumed:
        _executeAction(widget.model.onResume, 'onResume');
        break;
      case AppLifecycleState.paused:
        _executeAction(widget.model.onPause, 'onPause');
        break;
      case AppLifecycleState.inactive:
        _executeAction(widget.model.onInactive, 'onInactive');
        break;
      case AppLifecycleState.hidden:
        _executeAction(widget.model.onHidden, 'onHidden');
        break;
      case AppLifecycleState.detached:
        _executeAction(widget.model.onDetached, 'onDetached');
        break;
    }
  }

  @override
  void deactivate() {
    if (_isMounted) {
      _executeAction(widget.model.onDeactivate, 'onDeactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // In Flutter it's generally unsafe to use BuildContext in dispose.
    // We still allow it for logging and lightweight actions, but execute
    // immediately (not post-frame) and before marking unmounted.
    _executeAction(widget.model.onDispose, 'onDispose', forceImmediate: true);
    _isMounted = false;
    WidgetsBinding.instance.removeObserver(this);
    RegistryNotifier.instance.listenable.removeListener(_onRegistryChanged);
    super.dispose();
  }

  void _executeAction(
    Map<String, dynamic>? action,
    String actionName, {
    bool forceImmediate = false,
  }) {
    if (action == null) return;

    // For dispose we may need to run even while unmounting.
    if (!_isMounted && !forceImmediate) return;

    void run() {
      try {
        Stac.onCallFromJson(action, context);
      } catch (e, stackTrace) {
        AppLogger.e('Error executing $actionName', e, stackTrace);
      }
    }

    if (forceImmediate) {
      run();
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isMounted) return;
      run();
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isMounted) {
        _executeAction(widget.model.onBuild, 'onBuild');
      }
    });
    // Build child fresh each time so template vars get resolved
    return Stac.fromJson(widget.model.child, context) ?? Container();
  }
}
