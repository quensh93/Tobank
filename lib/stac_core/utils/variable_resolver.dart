import '../loaders/tobank_styles_loader.dart';
import '../../core/helpers/logger.dart';
import 'package:stac/stac.dart';

/// Resolve variables in JSON while preserving value types (numbers, bools, etc.)
///
/// Workaround for STAC's variable resolver which always converts values to strings.
/// When a string is EXACTLY a variable reference (like "{{appStyles.button.primary.elevation}}"),
/// returns the actual value type (number, bool, etc.) instead of converting it to a string.
dynamic resolveVariablesPreservingTypes(dynamic json, StacRegistry registry) {
  if (json is String) {
    final exactMatch = RegExp(r'^{{\s*([^}]+)\s*}}$').firstMatch(json);
    if (exactMatch != null) {
      final variableName = exactMatch.group(1)?.trim() ?? '';
      if (variableName.startsWith('appStyles.')) {
        final base = variableName.substring('appStyles.'.length);
        final parts = base.split('.');
        final isStyleObjectRef =
            parts.length == 1 ||
            (parts.length == 2 &&
                (parts.first == 'text' ||
                    parts.first == 'button' ||
                    parts.first == 'input'));
        if (isStyleObjectRef) {
          final built = TobankStylesLoader.buildStyleObject(variableName);
          if (built != null) {
            return built;
          }
        }
      }
      final value = registry.getValue(variableName);
      if (value != null) {
        if (variableName.contains('fontSize') ||
            variableName.contains('height') ||
            variableName.contains('width') ||
            variableName.contains('padding') ||
            variableName.contains('margin') ||
            variableName.contains('elevation') ||
            variableName.contains('borderRadius')) {
          AppLogger.dc(
            LogCategory.json,
            '   🔍 Resolving numeric variable: $variableName',
          );
          AppLogger.dc(
            LogCategory.json,
            '      Retrieved type: ${value.runtimeType}, value: $value',
          );
        }

        dynamic converted = value;
        bool shouldConvert = true;

        final lowerName = variableName.toLowerCase();
        if (lowerName.contains('mobile') ||
            lowerName.contains('nationalcode') ||
            lowerName.contains('id') ||
            lowerName.endsWith('code')) {
          if (lowerName.contains('mobile') ||
              lowerName.contains('phone') ||
              lowerName.contains('national') ||
              (lowerName.contains('code') && !lowerName.contains('color')) ||
              variableName.endsWith('Id') ||
              variableName == 'id') {
            shouldConvert = false;
            AppLogger.dc(
              LogCategory.json,
              '   🛡️ Skipping numeric conversion for identifier: $variableName',
            );
          }
        }

        if (shouldConvert) {
          converted = _convertStringToTypeIfNeeded(value);
        }

        if (value is String && converted is! String) {
          AppLogger.dc(
            LogCategory.json,
            '   🔄 Converted $variableName from String to ${converted.runtimeType}: "$value" -> $converted',
          );
        } else if (value is! String && converted is num) {
          AppLogger.dc(
            LogCategory.json,
            '   ✅ Preserved numeric type for $variableName: ${converted.runtimeType} = $converted',
          );
        }

        return converted;
      }
      return json;
    }

    return json.replaceAllMapped(RegExp(r'{{(.*?)}}'), (match) {
      final variableName = match.group(1)?.trim();
      var value = registry.getValue(variableName ?? '');

      if (value == null &&
          variableName != null &&
          variableName.startsWith('appData.')) {
        final formKey = variableName.replaceFirst('appData.', 'form.');
        value = registry.getValue(formKey);
        if (value != null) {
          registry.setValue(variableName, value);
        }
      }

      return value != null ? value.toString() : match.group(0) ?? '';
    });
  } else if (json is Map<String, dynamic>) {
    if (json.containsKey('type') && json['type'] == 'alias') {
      final val = json['value'];
      if (val is String) {
        final built = TobankStylesLoader.buildStyleObject(val);
        if (built != null) {
          return built;
        }
      }
    }
    final resolved = json.map(
      (key, value) =>
          MapEntry(key, resolveVariablesPreservingTypes(value, registry)),
    );
    // CRITICAL FIX: Text widgets require "data" to be a String.
    // After variable resolution and numeric conversion, the "data" field
    // may become an int/double (e.g. promissory.fees.total: "200100" -> 200100).
    // StacText.fromJson does `json['data'] as String` which crashes on non-String types.
    if (resolved['type'] == 'text' &&
        resolved.containsKey('data') &&
        resolved['data'] is! String) {
      resolved['data'] = resolved['data'].toString();
    }
    return resolved;
  } else if (json is List) {
    return json
        .map((item) => resolveVariablesPreservingTypes(item, registry))
        .toList();
  }
  return json;
}

/// Convert string representations back to their original types (numbers, bools).
///
/// CRITICAL FIX: Strings starting with '0' (length > 1) are NOT converted —
/// preserves phone numbers (09...) and national codes (00...) as strings.
dynamic _convertStringToTypeIfNeeded(dynamic value) {
  if (value is num || value is bool) {
    return value;
  }

  if (value is String) {
    if (value.startsWith('0') && value.length > 1) {
      return value;
    }

    final intValue = int.tryParse(value);
    if (intValue != null) return intValue;

    final doubleValue = double.tryParse(value);
    if (doubleValue != null) return doubleValue;

    if (value.toLowerCase() == 'true') return true;
    if (value.toLowerCase() == 'false') return false;

    return value;
  }

  return value;
}
