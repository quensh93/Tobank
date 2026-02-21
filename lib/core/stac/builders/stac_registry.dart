import 'package:stac_core/stac_core.dart';

/// Mock StacRegistry for STAC DSL files.
///
/// This allows DSL files to call [StacRegistry.instance.getValue()] during JSON
/// generation (stac build) without importing the Flutter-dependent stac package.
/// In the real app, the real StacRegistry from package:stac is used.
class StacRegistry {
  static final StacRegistry instance = StacRegistry._();
  StacRegistry._();

  final Map<String, dynamic> _values = {};

  /// Retrieve a value from the registry.
  /// During DSL compilation, this will typically return null unless values
  /// were explicitly set in the DSL code (which is rare).
  dynamic getValue(String key) {
    return _values[key];
  }

  /// Sets a value in the registry.
  void setValue(String key, dynamic value) {
    _values[key] = value;
  }
}
