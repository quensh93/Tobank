import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../../../helpers/logger.dart';
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
        LogCategory.stacRegistry,
        'StatefulWidget: Registry changed, triggering rebuild',
      );
      final selectedImage = StacRegistry.instance.getValue('selectedImage');
      AppLogger.dc(
        LogCategory.stacRegistry,
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
    // Resolve all template expressions (including ternary) before parsing
    final resolvedJson = _resolveExpressionsInJson(widget.model.child);
    return Stac.fromJson(resolvedJson, context) ?? Container();
  }

  /// Keys in a reactiveListView widget whose templates must NOT be resolved
  /// by the StatefulWidgetParser. ReactiveListViewParser resolves these itself
  /// (they contain {{item.*}} / {{isSelected}} / {{error}} placeholders).
  static const _reactiveListViewProtectedKeys = {
    'itemTemplate',
    'onItemTap',
    'errorWidget',
    'emptyWidget',
    'loadingWidget',
  };

  /// Keys in a reactiveElevatedButton widget whose templates must NOT be
  /// resolved by the StatefulWidgetParser at build time. Action templates like
  /// {{selectedDeposit.depositNumber}} must be resolved at EXECUTION time
  /// (by CustomNetworkRequestActionParser / CustomSetValueActionParser)
  /// so they always use the latest registry values.
  static const _reactiveElevatedButtonProtectedKeys = {
    'onPressed',
    'rawOnPressed',
  };

  /// Keys in a registryReactive widget that must stay unresolved until the
  /// registryReactive parser rebuilds its child from current registry values.
  static const _registryReactiveProtectedKeys = {
    'child',
  };

  /// Resolves all {{...}} expressions in JSON, including ternary and negation.
  ///
  /// When a `reactiveListView` widget is encountered, its template-carrying
  /// keys (itemTemplate, onItemTap, etc.) are kept as-is so that
  /// [ReactiveListViewParser] can resolve them with per-item data.
  ///
  /// When a `reactiveElevatedButton` widget is encountered, its action payload
  /// (`onPressed`/`rawOnPressed`) is kept raw so action parsers resolve
  /// templates at execution time using the latest registry values.
  dynamic _resolveExpressionsInJson(dynamic json) {
    if (json is String) {
      return _resolveTemplateString(json);
    } else if (json is Map<String, dynamic>) {
      final widgetType = json['type'];
      final isReactiveListView = widgetType == 'reactiveListView';
      final isReactiveElevatedButton = widgetType == 'reactiveElevatedButton';
      final isRegistryReactive = widgetType == 'registryReactive';
      return json.map((key, value) {
        // Skip resolution for reactive list view template keys
        if (isReactiveListView &&
            _reactiveListViewProtectedKeys.contains(key)) {
          return MapEntry(key, value);
        }
        // Skip resolution for reactive elevated button action keys
        if (isReactiveElevatedButton &&
            _reactiveElevatedButtonProtectedKeys.contains(key)) {
          if (key == 'onPressed') {
            try {
              final jsonStr = jsonEncode(value);
              final escaped = jsonStr.replaceAll('{{', '__STAC_OPEN__');
              return MapEntry('rawOnPressed', escaped);
            } catch (_) {
              return MapEntry(key, value);
            }
          }
          return MapEntry(key, value);
        }
        if (isRegistryReactive &&
            _registryReactiveProtectedKeys.contains(key)) {
          return MapEntry(key, value);
        }
        return MapEntry(key, _resolveExpressionsInJson(value));
      });
    } else if (json is Map) {
      final typed = Map<String, dynamic>.from(json);
      final widgetType = typed['type'];
      final isReactiveListView = widgetType == 'reactiveListView';
      final isReactiveElevatedButton = widgetType == 'reactiveElevatedButton';
      final isRegistryReactive = widgetType == 'registryReactive';
      return typed.map((key, value) {
        if (isReactiveListView &&
            _reactiveListViewProtectedKeys.contains(key)) {
          return MapEntry(key, value);
        }
        if (isReactiveElevatedButton &&
            _reactiveElevatedButtonProtectedKeys.contains(key)) {
          if (key == 'onPressed') {
            try {
              final jsonStr = jsonEncode(value);
              final escaped = jsonStr.replaceAll('{{', '__STAC_OPEN__');
              return MapEntry('rawOnPressed', escaped);
            } catch (_) {
              return MapEntry(key, value);
            }
          }
          return MapEntry(key, value);
        }
        if (isRegistryReactive &&
            _registryReactiveProtectedKeys.contains(key)) {
          return MapEntry(key, value);
        }
        return MapEntry(key, _resolveExpressionsInJson(value));
      });
    } else if (json is List) {
      return json.map((item) => _resolveExpressionsInJson(item)).toList();
    }
    return json;
  }

  /// Resolves template expressions in a string.
  dynamic _resolveTemplateString(String text) {
    if (!text.contains('{{') || !text.contains('}}')) return text;

    final matches = RegExp(r'\{\{([^}]+)\}\}').allMatches(text).toList();
    if (matches.isEmpty) return text;

    // If the entire string is a single {{expr}}, return the evaluated value (preserving type)
    if (matches.length == 1 && matches.first.group(0) == text) {
      final expr = matches.first.group(1)?.trim();
      if (expr == null || expr.isEmpty) return text;
      final result = _evalExpression(expr);
      return result ?? text;
    }

    // Otherwise, do string interpolation
    return text.replaceAllMapped(RegExp(r'\{\{([^}]+)\}\}'), (match) {
      final expr = match.group(1)?.trim();
      if (expr == null || expr.isEmpty) return match.group(0) ?? '';
      final value = _evalExpression(expr);
      return value?.toString() ?? match.group(0) ?? '';
    });
  }

  /// Evaluates an expression string.
  dynamic _evalExpression(String expr) {
    // Handle ternary expression: "condition ? trueValue : falseValue"
    final ternaryMatch = RegExp(
      r'^(.+?)\s*\?\s*(.+?)\s*:\s*(.+)$',
    ).firstMatch(expr);
    if (ternaryMatch != null) {
      final conditionExpr = ternaryMatch.group(1)!.trim();
      final trueValue = ternaryMatch.group(2)!.trim();
      final falseValue = ternaryMatch.group(3)!.trim();

      final conditionResult = _evalCondition(conditionExpr);
      final resultExpr = conditionResult ? trueValue : falseValue;

      return _parseValue(resultExpr);
    }

    // Handle negation: "!variableName"
    if (expr.startsWith('!')) {
      final varName = expr.substring(1).trim();
      final value = StacRegistry.instance.getValue(varName);
      return !_toBool(value);
    }

    // Simple variable lookup
    return StacRegistry.instance.getValue(expr);
  }

  /// Evaluates a condition expression and returns a boolean.
  bool _evalCondition(String conditionExpr) {
    if (conditionExpr.startsWith('!')) {
      final varName = conditionExpr.substring(1).trim();
      final value = StacRegistry.instance.getValue(varName);
      return !_toBool(value);
    }
    final value = StacRegistry.instance.getValue(conditionExpr);
    return _toBool(value);
  }

  /// Converts a value to boolean.
  bool _toBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is String) {
      final lower = value.toLowerCase();
      return lower == 'true' || lower == '1';
    }
    if (value is num) return value != 0;
    return false;
  }

  /// Parses a string value to its appropriate type.
  dynamic _parseValue(String value) {
    if (value == 'true') return true;
    if (value == 'false') return false;
    if (value == 'null') return null;

    final intVal = int.tryParse(value);
    if (intVal != null) return intVal;

    final doubleVal = double.tryParse(value);
    if (doubleVal != null) return doubleVal;

    // Check if it's a registry variable or nested expression
    if (value.contains('{{')) {
      return _resolveTemplateString(value);
    }

    // Try registry lookup for simple variable names
    if (!value.contains(' ') &&
        !value.startsWith('"') &&
        !value.startsWith("'")) {
      final registryValue = StacRegistry.instance.getValue(value);
      if (registryValue != null) return registryValue;
    }

    // Strip quotes if present
    if ((value.startsWith('"') && value.endsWith('"')) ||
        (value.startsWith("'") && value.endsWith("'"))) {
      return value.substring(1, value.length - 1);
    }

    return value;
  }
}
