import '../config/sdui_config.dart';
import '../registry/stac_widget_loader.dart';
import 'flow_registry.dart';
import 'nav_modes.dart';

/// Outcome of resolving a logical `fileName` + [NavModes] into a concrete
/// navigation source. Consumed by the navigate parser, which feeds each
/// variant into the matching existing `StacWidgetResolver` branch.
sealed class NavResolution {
  const NavResolution();
}

/// Resolved to a Dart-built screen (registry JSON).
class NavDart extends NavResolution {
  final Map<String, dynamic> widgetJson;
  const NavDart(this.widgetJson);
}

/// Resolved to a local JSON asset path.
class NavAsset extends NavResolution {
  final String assetPath;
  const NavAsset(this.assetPath);
}

/// Resolved to a network fetch (real backend). Carries the full request map
/// (`url`/`method`/`headers`/`body`) matching the config-resolve contract, so
/// the emitted call is identical to the legacy hand-written `request` block.
class NavNetwork extends NavResolution {
  final Map<String, dynamic> request;
  const NavNetwork(this.request);

  String get url => request['url'] as String;
}

/// Construction-time failure (missing Dart key / unknown flow). Surfaced
/// through the parser's existing error path — no new error UX.
class NavError extends NavResolution {
  final String message;
  const NavError(this.message);
}

/// Resolves `fileName` + [NavModes] (+ optional `pathOverride`) into a
/// [NavResolution]. Pure: builds inputs only, never widgets.
///
/// Precedence: `pathOverride` (interpreted by the active mode) wins; otherwise
/// the address is derived by convention. The mode only re-expresses a source
/// choice that already exists — the resolved address is byte-identical to what
/// the corresponding legacy field would have produced.
class FlowSourceResolver {
  FlowSourceResolver._();

  /// [fileName] may be null only when [pathOverride] is supplied (the override
  /// fully specifies the target).
  static NavResolution resolve({
    String? fileName,
    required NavModes navMode,
    String? pathOverride,
  }) {
    final hasOverride = pathOverride != null && pathOverride.isNotEmpty;

    switch (navMode) {
      case NavModes.dart:
        final key = hasOverride ? pathOverride : fileName;
        final widgetJson = StacWidgetLoader.loadWidgetJson(key);
        return widgetJson != null
            ? NavDart(widgetJson)
            : NavError('Dart screen not found: $key');

      case NavModes.localJson:
        if (hasOverride) return NavAsset(pathOverride);
        if (fileName == null) return const NavError('localJson needs fileName');
        final flow = FlowRegistry.flowOf(fileName);
        if (flow == null) {
          return NavError('No flow matches fileName: $fileName');
        }
        return NavAsset('lib/stac/tobank/flows/$flow/json/$fileName.json');

      case NavModes.apiJson:
        if (!hasOverride && fileName == null) {
          return const NavError('apiJson needs fileName');
        }
        final url = hasOverride ? pathOverride : SduiConfig.resolveUrl(fileName!);
        return NavNetwork(configResolveRequest(url));
    }
  }

  /// The fixed config-resolve request contract used by every apiJson screen.
  /// Mirrors the hand-written `request` blocks so behavior is identical.
  static Map<String, dynamic> configResolveRequest(String url) => {
        'url': url,
        'method': 'post',
        'headers': {'Content-Type': 'application/json', 'Accept': '*/*'},
        'body': {
          'operator': 'is',
          'dimension': {'app': 'mobile'},
        },
      };
}
