import 'dart:convert';

const String _rawOnPressedKey = 'rawOnPressed';
const String _onPressedKey = 'onPressed';
const String _escapeToken = '__STAC_OPEN__';
const String _templateOpenToken = '{{';

/// Protects reactiveElevatedButton onPressed payloads from early template
/// resolution by tunneling the action JSON into [rawOnPressed].
///
/// Rules:
/// - If widget `type` is `reactiveElevatedButton` and `onPressed` exists,
///   move it to `rawOnPressed` as escaped JSON.
/// - If `rawOnPressed` already exists, leave it unchanged (idempotent).
/// - Recursively processes nested maps/lists.
dynamic tunnelReactiveButtonActions(dynamic json) {
  if (json is List) {
    return json.map(tunnelReactiveButtonActions).toList();
  }

  if (json is Map) {
    final source = Map<String, dynamic>.from(json);
    final isReactiveButton = source['type'] == 'reactiveElevatedButton';

    final transformed = <String, dynamic>{};

    for (final entry in source.entries) {
      final key = entry.key;
      final value = entry.value;

      if (isReactiveButton && key == _rawOnPressedKey) {
        transformed[key] = value;
        continue;
      }

      if (isReactiveButton && key == _onPressedKey) {
        // Already tunneled: ignore legacy key so raw payload stays authoritative.
        if (source[_rawOnPressedKey] is String) {
          continue;
        }

        try {
          final jsonString = jsonEncode(value);
          transformed[_rawOnPressedKey] = jsonString.replaceAll(
            _templateOpenToken,
            _escapeToken,
          );
          continue;
        } catch (_) {
          // Fallback for non-encodable payloads.
          transformed[key] = value;
          continue;
        }
      }

      transformed[key] = tunnelReactiveButtonActions(value);
    }

    return transformed;
  }

  return json;
}
