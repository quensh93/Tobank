import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
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
    return _StatefulWidgetWrapper(
      model: model,
      child: Stac.fromJson(model.child, context) ?? Container(),
    );
  }
}

class _StatefulWidgetWrapper extends StatefulWidget {
  final StatefulWidgetModel model;
  final Widget child;

  const _StatefulWidgetWrapper({
    required this.model,
    required this.child,
  });

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
    _executeAction(widget.model.onInit, 'onInit');
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
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void dispose() {
    _isMounted = false;
    _executeAction(widget.model.onDispose, 'onDispose');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _executeAction(Map<String, dynamic>? action, String actionName) {
    if (action != null && _isMounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_isMounted) return;
        try {
          Stac.onCallFromJson(action, context);
        } catch (e, stackTrace) {
          debugPrint('Error executing $actionName: $e');
          debugPrint('Stack trace: $stackTrace');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isMounted) {
        _executeAction(widget.model.onBuild, 'onBuild');
      }
    });
    return widget.child;
  }
}
