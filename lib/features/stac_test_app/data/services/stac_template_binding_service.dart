import 'dart:convert';
import '../../../../core/helpers/logger.dart';

/// Service for applying data binding to STAC templates
/// 
/// Replaces {{variable}} placeholders in template JSON with values from data JSON
class StacTemplateBindingService {
  /// Apply data to template by replacing {{variable}} placeholders
  /// 
  /// This recursively processes the template and replaces all {{variable}} 
  /// placeholders with corresponding values from the data map.
  static Map<String, dynamic> applyDataToTemplate(
    Map<String, dynamic> template,
    Map<String, dynamic> data,
  ) {
    try {
      // Deep clone the template to avoid modifying the original
      final clonedTemplate = jsonDecode(jsonEncode(template)) as Map<String, dynamic>;
      
      // Recursively process the template
      _processTemplateRecursively(clonedTemplate, data);
      
      return clonedTemplate;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to apply data to template', e, stackTrace);
      rethrow;
    }
  }

  /// Recursively process template and replace {{variable}} placeholders
  static void _processTemplateRecursively(
    dynamic template,
    Map<String, dynamic> data,
  ) {
    if (template is Map) {
      for (final key in template.keys.toList()) {
        final value = template[key];

        if (value is String) {
          // Check if the string contains {{variable}} placeholders
          if (value.contains('{{') && value.contains('}}')) {
            // Replace all placeholders in the string
            template[key] = _replacePlaceholders(value, data);
          }
        } else if (value is Map || value is List) {
          // Recursively process nested maps and lists
          _processTemplateRecursively(value, data);
        }
      }
    } else if (template is List) {
      for (int i = 0; i < template.length; i++) {
        _processTemplateRecursively(template[i], data);
      }
    }
  }

  /// Replace {{variable}} placeholders in a string with values from data
  static String _replacePlaceholders(String text, Map<String, dynamic> data) {
    final regex = RegExp(r'\{\{([^}]+)\}\}');
    String result = text;

    for (final match in regex.allMatches(text)) {
      final placeholder = match.group(0)!; // Full match: {{variable}}
      final variableName = match.group(1)!.trim(); // Variable name: variable

      // Get value from data (supports nested access with dot notation)
      final value = _getNestedValue(data, variableName);

      if (value != null) {
        result = result.replaceAll(placeholder, value.toString());
      } else {
        // If value not found, keep the placeholder (or replace with empty string)
        AppLogger.w('Variable not found in data: $variableName');
      }
    }

    return result;
  }

  /// Get nested value from data map using dot notation
  /// 
  /// Example: "user.profile.name" -> data['user']['profile']['name']
  static dynamic _getNestedValue(Map<String, dynamic> data, String key) {
    if (!key.contains('.')) {
      // Simple key access
      return data[key];
    }

    // Nested key access
    final keys = key.split('.');
    dynamic current = data;

    for (final k in keys) {
      if (current is Map<String, dynamic>) {
        current = current[k];
        if (current == null) {
          return null;
        }
      } else {
        return null;
      }
    }

    return current;
  }
}

