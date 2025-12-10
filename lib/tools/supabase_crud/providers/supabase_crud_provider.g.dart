// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supabase_crud_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for Supabase CRUD service

@ProviderFor(supabaseCrudService)
const supabaseCrudServiceProvider = SupabaseCrudServiceProvider._();

/// Provider for Supabase CRUD service

final class SupabaseCrudServiceProvider
    extends
        $FunctionalProvider<
          SupabaseCrudService,
          SupabaseCrudService,
          SupabaseCrudService
        >
    with $Provider<SupabaseCrudService> {
  /// Provider for Supabase CRUD service
  const SupabaseCrudServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseCrudServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseCrudServiceHash();

  @$internal
  @override
  $ProviderElement<SupabaseCrudService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SupabaseCrudService create(Ref ref) {
    return supabaseCrudService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupabaseCrudService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupabaseCrudService>(value),
    );
  }
}

String _$supabaseCrudServiceHash() =>
    r'2800fd4c5ec5a59d37ed80398cfaec5fefa052b5';

/// Provider for listing screens

@ProviderFor(screensList)
const screensListProvider = ScreensListFamily._();

/// Provider for listing screens

final class ScreensListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ScreenMetadata>>,
          List<ScreenMetadata>,
          FutureOr<List<ScreenMetadata>>
        >
    with
        $FutureModifier<List<ScreenMetadata>>,
        $FutureProvider<List<ScreenMetadata>> {
  /// Provider for listing screens
  const ScreensListProvider._({
    required ScreensListFamily super.from,
    required ({
      int? limit,
      String? startAfter,
      String? orderBy,
      bool descending,
    })
    super.argument,
  }) : super(
         retry: null,
         name: r'screensListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$screensListHash();

  @override
  String toString() {
    return r'screensListProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<ScreenMetadata>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ScreenMetadata>> create(Ref ref) {
    final argument =
        this.argument
            as ({
              int? limit,
              String? startAfter,
              String? orderBy,
              bool descending,
            });
    return screensList(
      ref,
      limit: argument.limit,
      startAfter: argument.startAfter,
      orderBy: argument.orderBy,
      descending: argument.descending,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ScreensListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$screensListHash() => r'308740e183e01cd59af14cbbfdfc2a97252ddce5';

/// Provider for listing screens

final class ScreensListFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<ScreenMetadata>>,
          ({int? limit, String? startAfter, String? orderBy, bool descending})
        > {
  const ScreensListFamily._()
    : super(
        retry: null,
        name: r'screensListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for listing screens

  ScreensListProvider call({
    int? limit,
    String? startAfter,
    String? orderBy,
    bool descending = false,
  }) => ScreensListProvider._(
    argument: (
      limit: limit,
      startAfter: startAfter,
      orderBy: orderBy,
      descending: descending,
    ),
    from: this,
  );

  @override
  String toString() => r'screensListProvider';
}

/// Provider for getting a specific screen

@ProviderFor(screen)
const screenProvider = ScreenFamily._();

/// Provider for getting a specific screen

final class ScreenProvider
    extends
        $FunctionalProvider<
          AsyncValue<ScreenMetadata?>,
          ScreenMetadata?,
          FutureOr<ScreenMetadata?>
        >
    with $FutureModifier<ScreenMetadata?>, $FutureProvider<ScreenMetadata?> {
  /// Provider for getting a specific screen
  const ScreenProvider._({
    required ScreenFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'screenProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$screenHash();

  @override
  String toString() {
    return r'screenProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ScreenMetadata?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ScreenMetadata?> create(Ref ref) {
    final argument = this.argument as String;
    return screen(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ScreenProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$screenHash() => r'd8a31e61df17159755d778f517596c6333e7007a';

/// Provider for getting a specific screen

final class ScreenFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ScreenMetadata?>, String> {
  const ScreenFamily._()
    : super(
        retry: null,
        name: r'screenProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for getting a specific screen

  ScreenProvider call(String id) => ScreenProvider._(argument: id, from: this);

  @override
  String toString() => r'screenProvider';
}

/// Provider for getting screen JSON data

@ProviderFor(screenJson)
const screenJsonProvider = ScreenJsonFamily._();

/// Provider for getting screen JSON data

final class ScreenJsonProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>?>,
          Map<String, dynamic>?,
          FutureOr<Map<String, dynamic>?>
        >
    with
        $FutureModifier<Map<String, dynamic>?>,
        $FutureProvider<Map<String, dynamic>?> {
  /// Provider for getting screen JSON data
  const ScreenJsonProvider._({
    required ScreenJsonFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'screenJsonProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$screenJsonHash();

  @override
  String toString() {
    return r'screenJsonProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>?> create(Ref ref) {
    final argument = this.argument as String;
    return screenJson(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ScreenJsonProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$screenJsonHash() => r'53e2062bfbec8945f33f24e1c89028f2ef956ab8';

/// Provider for getting screen JSON data

final class ScreenJsonFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Map<String, dynamic>?>, String> {
  const ScreenJsonFamily._()
    : super(
        retry: null,
        name: r'screenJsonProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for getting screen JSON data

  ScreenJsonProvider call(String id) =>
      ScreenJsonProvider._(argument: id, from: this);

  @override
  String toString() => r'screenJsonProvider';
}

/// Provider for searching screens

@ProviderFor(searchScreens)
const searchScreensProvider = SearchScreensFamily._();

/// Provider for searching screens

final class SearchScreensProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ScreenMetadata>>,
          List<ScreenMetadata>,
          FutureOr<List<ScreenMetadata>>
        >
    with
        $FutureModifier<List<ScreenMetadata>>,
        $FutureProvider<List<ScreenMetadata>> {
  /// Provider for searching screens
  const SearchScreensProvider._({
    required SearchScreensFamily super.from,
    required ({String? query, List<String>? tags, int? limit}) super.argument,
  }) : super(
         retry: null,
         name: r'searchScreensProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchScreensHash();

  @override
  String toString() {
    return r'searchScreensProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<ScreenMetadata>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ScreenMetadata>> create(Ref ref) {
    final argument =
        this.argument as ({String? query, List<String>? tags, int? limit});
    return searchScreens(
      ref,
      query: argument.query,
      tags: argument.tags,
      limit: argument.limit,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SearchScreensProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchScreensHash() => r'59b08174063fa61f23d2a954d5c160197e389cba';

/// Provider for searching screens

final class SearchScreensFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<ScreenMetadata>>,
          ({String? query, List<String>? tags, int? limit})
        > {
  const SearchScreensFamily._()
    : super(
        retry: null,
        name: r'searchScreensProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for searching screens

  SearchScreensProvider call({String? query, List<String>? tags, int? limit}) =>
      SearchScreensProvider._(
        argument: (query: query, tags: tags, limit: limit),
        from: this,
      );

  @override
  String toString() => r'searchScreensProvider';
}

/// Provider for version history

@ProviderFor(versionHistory)
const versionHistoryProvider = VersionHistoryFamily._();

/// Provider for version history

final class VersionHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  /// Provider for version history
  const VersionHistoryProvider._({
    required VersionHistoryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'versionHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$versionHistoryHash();

  @override
  String toString() {
    return r'versionHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    final argument = this.argument as String;
    return versionHistory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VersionHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$versionHistoryHash() => r'472292d6d9d317e0d2963cc22347ce6c7a154051';

/// Provider for version history

final class VersionHistoryFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<Map<String, dynamic>>>,
          String
        > {
  const VersionHistoryFamily._()
    : super(
        retry: null,
        name: r'versionHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for version history

  VersionHistoryProvider call(String screenId) =>
      VersionHistoryProvider._(argument: screenId, from: this);

  @override
  String toString() => r'versionHistoryProvider';
}

/// Provider for screen statistics

@ProviderFor(screenStats)
const screenStatsProvider = ScreenStatsProvider._();

/// Provider for screen statistics

final class ScreenStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  /// Provider for screen statistics
  const ScreenStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'screenStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$screenStatsHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    return screenStats(ref);
  }
}

String _$screenStatsHash() => r'cb394ad827a76ef4a73c49ee3d2e6e99d4e57229';
