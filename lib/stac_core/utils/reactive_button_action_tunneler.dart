const String _rawOnPressedKey = 'rawOnPressed';
const String _onPressedKey = 'onPressed';
const String _escapeToken = '__STAC_OPEN__';
const String _templateOpenToken = '{{';

/// Protects reactiveElevatedButton onPressed payloads from early template
/// resolution by recursively escaping '{{' into '__STAC_OPEN__' in the action Map.
///
/// Rules:
/// - If widget `type` is `reactiveElevatedButton` and `onPressed` exists,
///   recursively escape all templates within the `onPressed` Map.
/// - Recursively processes nested maps/lists.
dynamic tunnelReactiveButtonActions(dynamic json) {
  if (json is List) {
    return json.map(tunnelReactiveButtonActions).toList();
  }

  if (json is Map) {
    final Map<String, dynamic> source = Map<String, dynamic>.from(json);
    final bool isReactiveButton = source['type'] == 'reactiveElevatedButton';

    final transformed = <String, dynamic>{};

    for (final entry in source.entries) {
      final key = entry.key;
      final value = entry.value;

      // Handle legacy rawOnPressed if it exists.
      if (isReactiveButton && key == _rawOnPressedKey) {
        transformed[key] = value;
        continue;
      }

      if (isReactiveButton && key == _onPressedKey) {
        // Already tunneled via rawOnPressed: ignore legacy key.
        if (source[_rawOnPressedKey] is String) {
          continue;
        }

        // If it's a Map, escape templates recursively.
        if (value is Map<String, dynamic>) {
          transformed[key] = _escapeTemplatesRecursive(value);
          continue;
        }

        // Fallback: if value is already a string or other type, just keep it.
        transformed[key] = value;
        continue;
      }

      transformed[key] = tunnelReactiveButtonActions(value);
    }

    return transformed;
  }

  return json;
}

dynamic _escapeTemplatesRecursive(dynamic value) {
  if (value is String) {
    return value.replaceAll(_templateOpenToken, _escapeToken);
  }
  if (value is List) {
    return value.map(_escapeTemplatesRecursive).toList();
  }
  if (value is Map) {
    return value.map(
      (k, v) => MapEntry(k as String, _escapeTemplatesRecursive(v)),
    );
  }
  return value;
}
