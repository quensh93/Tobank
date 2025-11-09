// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dio)
const dioProvider = DioProvider._();

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  const DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'099d91474eaf1924a5c392a53a04b55e651a9cdc';

@ProviderFor(apiService)
const apiServiceProvider = ApiServiceProvider._();

final class ApiServiceProvider
    extends $FunctionalProvider<ApiService, ApiService, ApiService>
    with $Provider<ApiService> {
  const ApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiServiceHash();

  @$internal
  @override
  $ProviderElement<ApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiService create(Ref ref) {
    return apiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiService>(value),
    );
  }
}

String _$apiServiceHash() => r'983361584fdff05743eb08586a8e9867a8c522de';

@ProviderFor(getData)
const getDataProvider = GetDataFamily._();

final class GetDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<Either<ApiError, Map<String, dynamic>>>,
          Either<ApiError, Map<String, dynamic>>,
          FutureOr<Either<ApiError, Map<String, dynamic>>>
        >
    with
        $FutureModifier<Either<ApiError, Map<String, dynamic>>>,
        $FutureProvider<Either<ApiError, Map<String, dynamic>>> {
  const GetDataProvider._({
    required GetDataFamily super.from,
    required Map<String, dynamic>? super.argument,
  }) : super(
         retry: null,
         name: r'getDataProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getDataHash();

  @override
  String toString() {
    return r'getDataProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Either<ApiError, Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Either<ApiError, Map<String, dynamic>>> create(Ref ref) {
    final argument = this.argument as Map<String, dynamic>?;
    return getData(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDataProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getDataHash() => r'9677436518e620d3358fa9038a5884a2ad3a6917';

final class GetDataFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Either<ApiError, Map<String, dynamic>>>,
          Map<String, dynamic>?
        > {
  const GetDataFamily._()
    : super(
        retry: null,
        name: r'getDataProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetDataProvider call(Map<String, dynamic>? queries) =>
      GetDataProvider._(argument: queries, from: this);

  @override
  String toString() => r'getDataProvider';
}

@ProviderFor(postData)
const postDataProvider = PostDataFamily._();

final class PostDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<Either<ApiError, Map<String, dynamic>>>,
          Either<ApiError, Map<String, dynamic>>,
          FutureOr<Either<ApiError, Map<String, dynamic>>>
        >
    with
        $FutureModifier<Either<ApiError, Map<String, dynamic>>>,
        $FutureProvider<Either<ApiError, Map<String, dynamic>>> {
  const PostDataProvider._({
    required PostDataFamily super.from,
    required Map<String, dynamic> super.argument,
  }) : super(
         retry: null,
         name: r'postDataProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$postDataHash();

  @override
  String toString() {
    return r'postDataProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Either<ApiError, Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Either<ApiError, Map<String, dynamic>>> create(Ref ref) {
    final argument = this.argument as Map<String, dynamic>;
    return postData(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PostDataProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$postDataHash() => r'2544e3eae5795b8d00463425b2ba680ac6818a5a';

final class PostDataFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Either<ApiError, Map<String, dynamic>>>,
          Map<String, dynamic>
        > {
  const PostDataFamily._()
    : super(
        retry: null,
        name: r'postDataProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PostDataProvider call(Map<String, dynamic> data) =>
      PostDataProvider._(argument: data, from: this);

  @override
  String toString() => r'postDataProvider';
}

@ProviderFor(putData)
const putDataProvider = PutDataFamily._();

final class PutDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<Either<ApiError, Map<String, dynamic>>>,
          Either<ApiError, Map<String, dynamic>>,
          FutureOr<Either<ApiError, Map<String, dynamic>>>
        >
    with
        $FutureModifier<Either<ApiError, Map<String, dynamic>>>,
        $FutureProvider<Either<ApiError, Map<String, dynamic>>> {
  const PutDataProvider._({
    required PutDataFamily super.from,
    required Map<String, dynamic> super.argument,
  }) : super(
         retry: null,
         name: r'putDataProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$putDataHash();

  @override
  String toString() {
    return r'putDataProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Either<ApiError, Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Either<ApiError, Map<String, dynamic>>> create(Ref ref) {
    final argument = this.argument as Map<String, dynamic>;
    return putData(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PutDataProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$putDataHash() => r'85f604678d355d07db19c7e1cc13d622057cec91';

final class PutDataFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Either<ApiError, Map<String, dynamic>>>,
          Map<String, dynamic>
        > {
  const PutDataFamily._()
    : super(
        retry: null,
        name: r'putDataProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PutDataProvider call(Map<String, dynamic> data) =>
      PutDataProvider._(argument: data, from: this);

  @override
  String toString() => r'putDataProvider';
}

@ProviderFor(deleteData)
const deleteDataProvider = DeleteDataProvider._();

final class DeleteDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<Either<ApiError, Map<String, dynamic>>>,
          Either<ApiError, Map<String, dynamic>>,
          FutureOr<Either<ApiError, Map<String, dynamic>>>
        >
    with
        $FutureModifier<Either<ApiError, Map<String, dynamic>>>,
        $FutureProvider<Either<ApiError, Map<String, dynamic>>> {
  const DeleteDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteDataHash();

  @$internal
  @override
  $FutureProviderElement<Either<ApiError, Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Either<ApiError, Map<String, dynamic>>> create(Ref ref) {
    return deleteData(ref);
  }
}

String _$deleteDataHash() => r'44f50038574cb53026749c11cdff7d0273bd7a42';

@ProviderFor(getHeaders)
const getHeadersProvider = GetHeadersProvider._();

final class GetHeadersProvider
    extends
        $FunctionalProvider<
          AsyncValue<Either<ApiError, Map<String, dynamic>>>,
          Either<ApiError, Map<String, dynamic>>,
          FutureOr<Either<ApiError, Map<String, dynamic>>>
        >
    with
        $FutureModifier<Either<ApiError, Map<String, dynamic>>>,
        $FutureProvider<Either<ApiError, Map<String, dynamic>>> {
  const GetHeadersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getHeadersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getHeadersHash();

  @$internal
  @override
  $FutureProviderElement<Either<ApiError, Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Either<ApiError, Map<String, dynamic>>> create(Ref ref) {
    return getHeaders(ref);
  }
}

String _$getHeadersHash() => r'db67b251339af788b449c9b63f3be308415f9a12';

@ProviderFor(getUserAgent)
const getUserAgentProvider = GetUserAgentProvider._();

final class GetUserAgentProvider
    extends
        $FunctionalProvider<
          AsyncValue<Either<ApiError, Map<String, dynamic>>>,
          Either<ApiError, Map<String, dynamic>>,
          FutureOr<Either<ApiError, Map<String, dynamic>>>
        >
    with
        $FutureModifier<Either<ApiError, Map<String, dynamic>>>,
        $FutureProvider<Either<ApiError, Map<String, dynamic>>> {
  const GetUserAgentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getUserAgentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getUserAgentHash();

  @$internal
  @override
  $FutureProviderElement<Either<ApiError, Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Either<ApiError, Map<String, dynamic>>> create(Ref ref) {
    return getUserAgent(ref);
  }
}

String _$getUserAgentHash() => r'b555d0a417435dd27e1809af31a1e37180e5eca8';
