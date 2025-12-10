import 'package:tobank_sdui/core/stac/registry/custom_component_registry.dart';
import 'package:tobank_sdui/core/validation/json_validator.dart';

/// STAC-specific JSON validator
///
/// Validates JSON structures against STAC framework requirements including:
/// - Required fields (type, properties)
/// - Widget type validation against registered parsers
/// - Action type validation against registered parsers
/// - Circular reference detection
/// - Nested structure validation
class StacJsonValidator implements JsonValidator {
  final List<ValidationError> _errors = [];
  final List<ValidationWarning> _warnings = [];
  final Set<String> _visitedNodes = {};
  
  /// Whether to enable strict validation mode
  final bool strict;
  
  /// Creates a new STAC JSON validator
  /// 
  /// If [strict] is true, warnings will be treated as errors
  StacJsonValidator({this.strict = false});

  /// Built-in STAC widget types from the framework
  static const Set<String> builtInWidgetTypes = {
    // Layout Widgets
    'align',
    'aspectRatio',
    'center',
    'column',
    'container',
    'expanded',
    'fittedBox',
    'flexible',
    'fractionallySizedBox',
    'limitedBox',
    'padding',
    'positioned',
    'row',
    'safeArea',
    'sizedBox',
    'spacer',
    'stack',
    'wrap',
    // Display Widgets
    'backdropFilter',
    'card',
    'carouselView',
    'circleAvatar',
    'clipOval',
    'clipRRect',
    'coloredBox',
    'icon',
    'iconButton',
    'image',
    'opacity',
    'placeholder',
    'visibility',
    // Interactive Widgets
    'alertDialog',
    'appBar',
    'autoComplete',
    'bottomNavigationBar',
    'checkBox',
    'chip',
    'circularProgressIndicator',
    'drawer',
    'dropdownMenu',
    'dynamicView',
    'elevatedButton',
    'filledButton',
    'floatingActionButton',
    'form',
    'gestureDetector',
    'inkWell',
    'linearProgressIndicator',
    'listTile',
    'listView',
    'networkWidget',
    'outlinedButton',
    'pageView',
    'radioGroup',
    'refreshIndicator',
    'scaffold',
    'singleChildScrollView',
    'slider',
    'sliverAppBar',
    'switch',
    'tabBar',
    'textButton',
    'textField',
    'textFormField',
    'webView',
    // Data Widgets
    'customScrollView',
    'gridView',
    'table',
    'tableCell',
    'tableRow',
    'text',
    'verticalDivider',
  };

  /// Built-in STAC action types from the framework
  static const Set<String> builtInActionTypes = {
    'back',
    'close',
    'copy',
    'hideDialog',
    'launch',
    'navigate',
    'refresh',
    'request',
    'setState',
    'share',
    'showDialog',
    'vibrate',
  };

  @override
  ValidationResult validate(Map<String, dynamic> json) {
    _errors.clear();
    _warnings.clear();
    _visitedNodes.clear();

    // Validate the root structure
    _validateNode(json, 'root');

    // Create and return result
    // In strict mode, treat warnings as errors
    final hasErrors = strict ? (_errors.isNotEmpty || _warnings.isNotEmpty) : _errors.isNotEmpty;
    
    if (!hasErrors) {
      return ValidationResult.success(warnings: List<ValidationWarning>.from(_warnings));
    } else {
      // In strict mode, convert warnings to errors
      final allErrors = strict 
          ? <ValidationError>[
              ...List<ValidationError>.from(_errors),
              ..._warnings.map((w) => ValidationError(
                path: w.path,
                message: w.message,
                value: w.value,
                code: w.code,
                suggestion: 'Strict mode: This warning is treated as an error',
              )),
            ]
          : List<ValidationError>.from(_errors);
      
      return ValidationResult.failure(
        errors: allErrors,
        warnings: strict ? <ValidationWarning>[] : List<ValidationWarning>.from(_warnings),
      );
    }
  }

  @override
  List<ValidationError> getErrors() => List.from(_errors);

  @override
  bool isValid() => _errors.isEmpty;

  /// Validates a single node in the JSON structure
  void _validateNode(
    Map<String, dynamic> json,
    String path, {
    int depth = 0,
  }) {
    // Check for circular references
    final nodeId = _generateNodeId(json);
    if (_visitedNodes.contains(nodeId)) {
      _errors.add(
        ValidationError(
          path: path,
          message: 'Circular reference detected',
          code: 'CIRCULAR_REFERENCE',
          suggestion: 'Remove circular references in your JSON structure',
        ),
      );
      return;
    }
    _visitedNodes.add(nodeId);

    // Check for maximum depth to prevent stack overflow
    if (depth > 50) {
      _errors.add(
        ValidationError(
          path: path,
          message: 'Maximum nesting depth exceeded (50 levels)',
          code: 'MAX_DEPTH_EXCEEDED',
          suggestion: 'Reduce the nesting depth of your JSON structure',
        ),
      );
      return;
    }

    // Validate required 'type' field
    if (!json.containsKey('type')) {
      _errors.add(
        ValidationError(
          path: path,
          message: 'Missing required field: type',
          code: 'MISSING_TYPE',
          suggestion: 'Add a "type" field to specify the widget type',
        ),
      );
      return; // Can't continue without type
    }

    final type = json['type'];
    if (type is! String) {
      _errors.add(
        ValidationError(
          path: '$path.type',
          message: 'Field "type" must be a string',
          value: type,
          code: 'INVALID_TYPE_VALUE',
          suggestion: 'Ensure "type" is a string value',
        ),
      );
      return;
    }

    // Validate widget type
    _validateWidgetType(type, path);

    // Validate child/children if present
    if (json.containsKey('child')) {
      final child = json['child'];
      if (child is Map<String, dynamic>) {
        _validateNode(child, '$path.child', depth: depth + 1);
      } else if (child != null) {
        _errors.add(
          ValidationError(
            path: '$path.child',
            message: 'Field "child" must be an object',
            value: child,
            code: 'INVALID_CHILD',
            suggestion: 'Ensure "child" is a valid JSON object',
          ),
        );
      }
    }

    if (json.containsKey('children')) {
      final children = json['children'];
      if (children is List) {
        for (var i = 0; i < children.length; i++) {
          final child = children[i];
          if (child is Map<String, dynamic>) {
            _validateNode(child, '$path.children[$i]', depth: depth + 1);
          } else {
            _errors.add(
              ValidationError(
                path: '$path.children[$i]',
                message: 'Child at index $i must be an object',
                value: child,
                code: 'INVALID_CHILD_ITEM',
                suggestion: 'Ensure all children are valid JSON objects',
              ),
            );
          }
        }
      } else if (children != null) {
        _errors.add(
          ValidationError(
            path: '$path.children',
            message: 'Field "children" must be an array',
            value: children,
            code: 'INVALID_CHILDREN',
            suggestion: 'Ensure "children" is a JSON array',
          ),
        );
      }
    }

    // Validate actions if present
    _validateActions(json, path);

    // Validate properties based on widget type
    _validateProperties(json, type, path);
  }

  /// Validates that a widget type is registered or built-in
  void _validateWidgetType(String type, String path) {
    final registry = CustomComponentRegistry.instance;

    // Check if it's a built-in widget
    if (builtInWidgetTypes.contains(type)) {
      return; // Valid built-in widget
    }

    // Check if it's a registered custom widget
    if (registry.hasWidgetParser(type)) {
      return; // Valid custom widget
    }

    // Widget type not found
    _errors.add(
      ValidationError(
        path: '$path.type',
        message: 'Unknown widget type: $type',
        value: type,
        code: 'UNKNOWN_WIDGET_TYPE',
        suggestion:
            'Use a built-in widget type or register a custom parser for "$type"',
      ),
    );
  }

  /// Validates action fields in the JSON
  void _validateActions(Map<String, dynamic> json, String path) {
    // Common action fields
    const actionFields = [
      'onPressed',
      'onTap',
      'onLongPress',
      'onChanged',
      'onSubmitted',
      'onRefresh',
    ];

    for (final field in actionFields) {
      if (json.containsKey(field)) {
        final action = json[field];
        if (action is Map<String, dynamic>) {
          _validateAction(action, '$path.$field');
        } else if (action is List) {
          for (var i = 0; i < action.length; i++) {
            if (action[i] is Map<String, dynamic>) {
              _validateAction(action[i], '$path.$field[$i]');
            }
          }
        } else if (action != null) {
          _errors.add(
            ValidationError(
              path: '$path.$field',
              message: 'Action must be an object or array of objects',
              value: action,
              code: 'INVALID_ACTION',
              suggestion: 'Ensure action is a valid JSON object',
            ),
          );
        }
      }
    }
  }

  /// Validates a single action object
  void _validateAction(Map<String, dynamic> action, String path) {
    // Validate required 'actionType' field
    if (!action.containsKey('actionType')) {
      _errors.add(
        ValidationError(
          path: path,
          message: 'Missing required field: actionType',
          code: 'MISSING_ACTION_TYPE',
          suggestion: 'Add an "actionType" field to specify the action',
        ),
      );
      return;
    }

    final actionType = action['actionType'];
    if (actionType is! String) {
      _errors.add(
        ValidationError(
          path: '$path.actionType',
          message: 'Field "actionType" must be a string',
          value: actionType,
          code: 'INVALID_ACTION_TYPE_VALUE',
          suggestion: 'Ensure "actionType" is a string value',
        ),
      );
      return;
    }

    // Validate action type
    _validateActionType(actionType, path);
  }

  /// Validates that an action type is registered or built-in
  void _validateActionType(String actionType, String path) {
    final registry = CustomComponentRegistry.instance;

    // Check if it's a built-in action
    if (builtInActionTypes.contains(actionType)) {
      return; // Valid built-in action
    }

    // Check if it's a registered custom action
    if (registry.hasActionParser(actionType)) {
      return; // Valid custom action
    }

    // Action type not found
    _errors.add(
      ValidationError(
        path: '$path.actionType',
        message: 'Unknown action type: $actionType',
        value: actionType,
        code: 'UNKNOWN_ACTION_TYPE',
        suggestion:
            'Use a built-in action type or register a custom parser for "$actionType"',
      ),
    );
  }

  /// Validates properties based on widget type
  void _validateProperties(
    Map<String, dynamic> json,
    String type,
    String path,
  ) {
    // Add warnings for common mistakes
    if (type == 'text' && !json.containsKey('data')) {
      _warnings.add(
        ValidationWarning(
          path: path,
          message: 'Text widget is missing "data" property',
          code: 'MISSING_TEXT_DATA',
        ),
      );
    }

    if (type == 'image' && !json.containsKey('src')) {
      _warnings.add(
        ValidationWarning(
          path: path,
          message: 'Image widget is missing "src" property',
          code: 'MISSING_IMAGE_SRC',
        ),
      );
    }

    // Validate that properties is an object if present
    if (json.containsKey('properties')) {
      final properties = json['properties'];
      if (properties is! Map<String, dynamic>) {
        _errors.add(
          ValidationError(
            path: '$path.properties',
            message: 'Field "properties" must be an object',
            value: properties,
            code: 'INVALID_PROPERTIES',
            suggestion: 'Ensure "properties" is a valid JSON object',
          ),
        );
      }
    }
  }

  /// Generates a unique ID for a node to detect circular references
  String _generateNodeId(Map<String, dynamic> json) {
    // Use object identity hash code
    return json.hashCode.toString();
  }
}
