import 'package:flutter/material.dart';
import '../../helpers/logger.dart';

/// Registry to store TextEditingController references for TextFormFields
/// This allows external code to update TextFormField values programmatically
class TextFormFieldControllerRegistry {
  static final TextFormFieldControllerRegistry _instance = 
      TextFormFieldControllerRegistry._internal();
  
  factory TextFormFieldControllerRegistry() => _instance;
  
  static TextFormFieldControllerRegistry get instance => _instance;
  
  TextFormFieldControllerRegistry._internal();

  /// Map of field IDs to their TextEditingControllers
  final Map<String, TextEditingController> _controllers = {};

  /// Register a controller for a field ID
  void register(String fieldId, TextEditingController controller) {
    _controllers[fieldId] = controller;
    AppLogger.d('Registered TextFormField controller for: $fieldId');
  }

  /// Unregister a controller
  void unregister(String fieldId) {
    _controllers.remove(fieldId);
    AppLogger.d('Unregistered TextFormField controller for: $fieldId');
  }

  /// Get a controller for a field ID
  TextEditingController? get(String fieldId) {
    return _controllers[fieldId];
  }

  /// Update the text value for a field ID
  bool updateValue(String fieldId, String value, {bool warnOnMissing = false}) {
    final controller = _controllers[fieldId];
    if (controller != null) {
      controller.text = value;
      AppLogger.d('Updated TextFormField value for: $fieldId = $value');
      return true;
    }
    if (warnOnMissing) {
      AppLogger.w('No controller found for field: $fieldId');
    }
    return false;
  }

  /// Clear all registered controllers
  void clear() {
    _controllers.clear();
  }
}
