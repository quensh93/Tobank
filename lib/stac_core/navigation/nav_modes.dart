/// The three navigation source modes for server-driven screens.
///
/// A navigate action declares one of these via `navMode`; the core resolves
/// the real address from the logical `fileName`. The mode only re-expresses a
/// source choice that already exists — it never changes what a screen loads.
enum NavModes {
  /// Load the Dart-built screen from the widget registry (`fileName` == key).
  dart,

  /// Load a local JSON asset: `lib/stac/tobank/flows/<flow>/json/<fileName>.json`.
  localJson,

  /// Fetch from the real config backend via `SduiConfig.resolveUrl(fileName)`.
  apiJson;

  /// Parses a raw JSON value (e.g. `"localJson"`) into a [NavModes].
  /// Returns `null` for null/unknown values — callers treat that as legacy.
  static NavModes? fromJson(Object? raw) {
    if (raw == null) return null;
    final value = raw.toString();
    for (final mode in NavModes.values) {
      if (mode.name == value) return mode;
    }
    return null;
  }
}
