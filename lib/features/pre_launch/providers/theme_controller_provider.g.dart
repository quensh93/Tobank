// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_controller_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider that manages the app's theme mode (light/dark)

@ProviderFor(ThemeController)
const themeControllerProvider = ThemeControllerProvider._();

/// Provider that manages the app's theme mode (light/dark)
final class ThemeControllerProvider
    extends $AsyncNotifierProvider<ThemeController, ThemeMode> {
  /// Provider that manages the app's theme mode (light/dark)
  const ThemeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeControllerHash();

  @$internal
  @override
  ThemeController create() => ThemeController();
}

String _$themeControllerHash() => r'105a91eb528d11305c0874387df3119eb2e9e604';

/// Provider that manages the app's theme mode (light/dark)

abstract class _$ThemeController extends $AsyncNotifier<ThemeMode> {
  FutureOr<ThemeMode> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ThemeMode>, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ThemeMode>, ThemeMode>,
              AsyncValue<ThemeMode>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
