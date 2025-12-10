/// Custom Component Registry
///
/// This library provides a centralized registry for custom STAC widgets and actions.
/// It allows you to register, retrieve, and manage custom parsers that extend the
/// core STAC framework.
///
/// Usage:
/// ```dart
/// import 'package:tobank_sdui/stac/registry/registry.dart';
///
/// // Register a custom widget
/// CustomComponentRegistry.instance.registerWidget(MyCustomWidgetParser());
///
/// // Register a custom action
/// CustomComponentRegistry.instance.registerAction(MyCustomActionParser());
///
/// // Register all custom parsers with STAC framework
/// await registerCustomParsers();
/// ```
library;

export 'custom_component_registry.dart';
export 'register_custom_parsers.dart';
