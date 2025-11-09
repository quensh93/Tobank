// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Dio provider

@ProviderFor(dio)
const dioProvider = DioProvider._();

/// Dio provider

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// Dio provider
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

String _$dioHash() => r'c0fabd48998b5cafd06f207bf33ec224cfcb42d0';

/// API Service provider

@ProviderFor(apiService)
const apiServiceProvider = ApiServiceProvider._();

/// API Service provider

final class ApiServiceProvider
    extends $FunctionalProvider<ApiService, ApiService, ApiService>
    with $Provider<ApiService> {
  /// API Service provider
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

/// User Repository provider

@ProviderFor(userRepository)
const userRepositoryProvider = UserRepositoryProvider._();

/// User Repository provider

final class UserRepositoryProvider
    extends $FunctionalProvider<UserRepository, UserRepository, UserRepository>
    with $Provider<UserRepository> {
  /// User Repository provider
  const UserRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userRepositoryHash();

  @$internal
  @override
  $ProviderElement<UserRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserRepository create(Ref ref) {
    return userRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserRepository>(value),
    );
  }
}

String _$userRepositoryHash() => r'8a4a8dc4c622778de3078fe6342dd9a32db6a917';

/// Get data provider

@ProviderFor(getData)
const getDataProvider = GetDataFamily._();

/// Get data provider

final class GetDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  /// Get data provider
  const GetDataProvider._({
    required GetDataFamily super.from,
    required Map<String, dynamic> super.argument,
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
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    final argument = this.argument as Map<String, dynamic>;
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

String _$getDataHash() => r'c09ce6c64173c944f5d88cbfed2ed042da99857e';

/// Get data provider

final class GetDataFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Map<String, dynamic>>,
          Map<String, dynamic>
        > {
  const GetDataFamily._()
    : super(
        retry: null,
        name: r'getDataProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Get data provider

  GetDataProvider call(Map<String, dynamic> queries) =>
      GetDataProvider._(argument: queries, from: this);

  @override
  String toString() => r'getDataProvider';
}

/// Post data provider

@ProviderFor(postData)
const postDataProvider = PostDataFamily._();

/// Post data provider

final class PostDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  /// Post data provider
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
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
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

String _$postDataHash() => r'd9f7a5de993c55b83d9b5974819f71d2a22e28fc';

/// Post data provider

final class PostDataFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Map<String, dynamic>>,
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

  /// Post data provider

  PostDataProvider call(Map<String, dynamic> data) =>
      PostDataProvider._(argument: data, from: this);

  @override
  String toString() => r'postDataProvider';
}

/// Put data provider

@ProviderFor(putData)
const putDataProvider = PutDataFamily._();

/// Put data provider

final class PutDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  /// Put data provider
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
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
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

String _$putDataHash() => r'c6bef114002cc3f08f6ac033dcdc6800ae77be03';

/// Put data provider

final class PutDataFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Map<String, dynamic>>,
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

  /// Put data provider

  PutDataProvider call(Map<String, dynamic> data) =>
      PutDataProvider._(argument: data, from: this);

  @override
  String toString() => r'putDataProvider';
}

/// Delete data provider

@ProviderFor(deleteData)
const deleteDataProvider = DeleteDataProvider._();

/// Delete data provider

final class DeleteDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  /// Delete data provider
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
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    return deleteData(ref);
  }
}

String _$deleteDataHash() => r'812839fdd3210193b383919f0b95307d5d005c41';

/// Get headers provider

@ProviderFor(getHeaders)
const getHeadersProvider = GetHeadersProvider._();

/// Get headers provider

final class GetHeadersProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  /// Get headers provider
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
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    return getHeaders(ref);
  }
}

String _$getHeadersHash() => r'213ad86a3a16176d972bd6011ea866ccd830f86f';

/// Get user agent provider

@ProviderFor(getUserAgent)
const getUserAgentProvider = GetUserAgentProvider._();

/// Get user agent provider

final class GetUserAgentProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  /// Get user agent provider
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
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    return getUserAgent(ref);
  }
}

String _$getUserAgentHash() => r'067b24b55c930104d6793918a67a6d0101c50ee6';
