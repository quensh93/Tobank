import 'package:stac/stac.dart';
import '../../helpers/logger.dart';

/// Custom Component Registry for project-specific STAC widgets and actions.
///
/// This registry manages custom parsers that extend the core STAC framework
/// without modifying the original package. It provides a centralized location
/// for registering and retrieving custom widget and action parsers.
///
/// Usage:
/// ```dart
/// // Register a custom widget parser
/// CustomComponentRegistry.instance.registerWidget(MyCustomWidgetParser());
///
/// // Register a custom action parser
/// CustomComponentRegistry.instance.registerAction(MyCustomActionParser());
///
/// // Get a registered parser
/// final parser = CustomComponentRegistry.instance.getWidgetParser('myCustomWidget');
/// ```
class CustomComponentRegistry {
  CustomComponentRegistry._internal();

  static final CustomComponentRegistry _singleton =
      CustomComponentRegistry._internal();

  factory CustomComponentRegistry() => _singleton;

  static CustomComponentRegistry get instance => _singleton;

  /// Storage for custom widget parsers
  final Map<String, StacParser> _widgetParsers = {};

  /// Storage for custom action parsers
  final Map<String, StacActionParser> _actionParsers = {};

  /// Register a custom widget parser.
  ///
  /// [parser] - The widget parser to register
  /// [override] - If true, allows overriding an existing parser with the same type
  ///
  /// Returns true if registration was successful, false if the parser type
  /// is already registered and override is false.
  bool registerWidget(StacParser parser, [bool override = false]) {
    final String type = parser.type;

    if (_widgetParsers.containsKey(type)) {
      if (override) {
        AppLogger.w('Custom widget parser "$type" is being overridden');
        _widgetParsers[type] = parser;
        return true;
      } else {
        AppLogger.w('Custom widget parser "$type" is already registered');
        return false;
      }
    } else {
      _widgetParsers[type] = parser;
      AppLogger.i('Custom widget parser "$type" registered successfully');
      return true;
    }
  }

  /// Register a custom action parser.
  ///
  /// [parser] - The action parser to register
  /// [override] - If true, allows overriding an existing parser with the same actionType
  ///
  /// Returns true if registration was successful, false if the parser actionType
  /// is already registered and override is false.
  bool registerAction(StacActionParser parser, [bool override = false]) {
    final String actionType = parser.actionType;

    if (_actionParsers.containsKey(actionType)) {
      if (override) {
        AppLogger.w('Custom action parser "$actionType" is being overridden');
        _actionParsers[actionType] = parser;
        return true;
      } else {
        AppLogger.w('Custom action parser "$actionType" is already registered');
        return false;
      }
    } else {
      _actionParsers[actionType] = parser;
      AppLogger.i('Custom action parser "$actionType" registered successfully');
      return true;
    }
  }

  /// Register multiple widget parsers at once.
  ///
  /// [parsers] - List of widget parsers to register
  /// [override] - If true, allows overriding existing parsers
  ///
  /// Returns a Future that completes when all parsers are registered.
  Future<void> registerAllWidgets(
    List<StacParser> parsers, [
    bool override = false,
  ]) async {
    for (final parser in parsers) {
      registerWidget(parser, override);
    }
  }

  /// Register multiple action parsers at once.
  ///
  /// [parsers] - List of action parsers to register
  /// [override] - If true, allows overriding existing parsers
  ///
  /// Returns a Future that completes when all parsers are registered.
  Future<void> registerAllActions(
    List<StacActionParser> parsers, [
    bool override = false,
  ]) async {
    for (final parser in parsers) {
      registerAction(parser, override);
    }
  }

  /// Get a registered widget parser by type.
  ///
  /// [type] - The widget type to look up
  ///
  /// Returns the parser if found, null otherwise.
  StacParser? getWidgetParser(String type) {
    return _widgetParsers[type];
  }

  /// Get a registered action parser by actionType.
  ///
  /// [actionType] - The action type to look up
  ///
  /// Returns the parser if found, null otherwise.
  StacActionParser? getActionParser(String actionType) {
    return _actionParsers[actionType];
  }

  /// Get all registered widget types.
  ///
  /// Returns a list of all registered widget type names.
  List<String> getRegisteredWidgets() {
    return _widgetParsers.keys.toList();
  }

  /// Get all registered action types.
  ///
  /// Returns a list of all registered action type names.
  List<String> getRegisteredActions() {
    return _actionParsers.keys.toList();
  }

  /// Check if a widget parser is registered.
  ///
  /// [type] - The widget type to check
  ///
  /// Returns true if a parser for this type is registered.
  bool hasWidgetParser(String type) {
    return _widgetParsers.containsKey(type);
  }

  /// Check if an action parser is registered.
  ///
  /// [actionType] - The action type to check
  ///
  /// Returns true if a parser for this actionType is registered.
  bool hasActionParser(String actionType) {
    return _actionParsers.containsKey(actionType);
  }

  /// Unregister a widget parser.
  ///
  /// [type] - The widget type to unregister
  ///
  /// Returns true if the parser was found and removed.
  bool unregisterWidget(String type) {
    if (_widgetParsers.containsKey(type)) {
      _widgetParsers.remove(type);
      AppLogger.i('Custom widget parser "$type" unregistered');
      return true;
    }
    return false;
  }

  /// Unregister an action parser.
  ///
  /// [actionType] - The action type to unregister
  ///
  /// Returns true if the parser was found and removed.
  bool unregisterAction(String actionType) {
    if (_actionParsers.containsKey(actionType)) {
      _actionParsers.remove(actionType);
      AppLogger.i('Custom action parser "$actionType" unregistered');
      return true;
    }
    return false;
  }

  /// Clear all registered custom parsers.
  ///
  /// This removes all widget and action parsers from the registry.
  void clearAll() {
    _widgetParsers.clear();
    _actionParsers.clear();
    AppLogger.i('All custom parsers cleared from registry');
  }

  /// Get a summary of registered parsers.
  ///
  /// Returns a map with counts and lists of registered parsers.
  Map<String, dynamic> getSummary() {
    return {
      'widgetCount': _widgetParsers.length,
      'actionCount': _actionParsers.length,
      'widgets': getRegisteredWidgets(),
      'actions': getRegisteredActions(),
    };
  }
}
