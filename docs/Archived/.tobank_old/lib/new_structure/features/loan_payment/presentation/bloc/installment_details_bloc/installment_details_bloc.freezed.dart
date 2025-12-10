// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'installment_details_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InstallmentDetailsEvent {
  InstallmentDetailsParams get params => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(InstallmentDetailsParams params)
        getInstallmentDetails,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(InstallmentDetailsParams params)? getInstallmentDetails,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(InstallmentDetailsParams params)? getInstallmentDetails,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetInstallmentDetails value)
        getInstallmentDetails,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetInstallmentDetails value)? getInstallmentDetails,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetInstallmentDetails value)? getInstallmentDetails,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of InstallmentDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InstallmentDetailsEventCopyWith<InstallmentDetailsEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InstallmentDetailsEventCopyWith<$Res> {
  factory $InstallmentDetailsEventCopyWith(InstallmentDetailsEvent value,
          $Res Function(InstallmentDetailsEvent) then) =
      _$InstallmentDetailsEventCopyWithImpl<$Res, InstallmentDetailsEvent>;
  @useResult
  $Res call({InstallmentDetailsParams params});
}

/// @nodoc
class _$InstallmentDetailsEventCopyWithImpl<$Res,
        $Val extends InstallmentDetailsEvent>
    implements $InstallmentDetailsEventCopyWith<$Res> {
  _$InstallmentDetailsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InstallmentDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? params = null,
  }) {
    return _then(_value.copyWith(
      params: null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as InstallmentDetailsParams,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetInstallmentDetailsImplCopyWith<$Res>
    implements $InstallmentDetailsEventCopyWith<$Res> {
  factory _$$GetInstallmentDetailsImplCopyWith(
          _$GetInstallmentDetailsImpl value,
          $Res Function(_$GetInstallmentDetailsImpl) then) =
      __$$GetInstallmentDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({InstallmentDetailsParams params});
}

/// @nodoc
class __$$GetInstallmentDetailsImplCopyWithImpl<$Res>
    extends _$InstallmentDetailsEventCopyWithImpl<$Res,
        _$GetInstallmentDetailsImpl>
    implements _$$GetInstallmentDetailsImplCopyWith<$Res> {
  __$$GetInstallmentDetailsImplCopyWithImpl(_$GetInstallmentDetailsImpl _value,
      $Res Function(_$GetInstallmentDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of InstallmentDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? params = null,
  }) {
    return _then(_$GetInstallmentDetailsImpl(
      null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as InstallmentDetailsParams,
    ));
  }
}

/// @nodoc

class _$GetInstallmentDetailsImpl implements _GetInstallmentDetails {
  const _$GetInstallmentDetailsImpl(this.params);

  @override
  final InstallmentDetailsParams params;

  @override
  String toString() {
    return 'InstallmentDetailsEvent.getInstallmentDetails(params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetInstallmentDetailsImpl &&
            (identical(other.params, params) || other.params == params));
  }

  @override
  int get hashCode => Object.hash(runtimeType, params);

  /// Create a copy of InstallmentDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetInstallmentDetailsImplCopyWith<_$GetInstallmentDetailsImpl>
      get copyWith => __$$GetInstallmentDetailsImplCopyWithImpl<
          _$GetInstallmentDetailsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(InstallmentDetailsParams params)
        getInstallmentDetails,
  }) {
    return getInstallmentDetails(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(InstallmentDetailsParams params)? getInstallmentDetails,
  }) {
    return getInstallmentDetails?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(InstallmentDetailsParams params)? getInstallmentDetails,
    required TResult orElse(),
  }) {
    if (getInstallmentDetails != null) {
      return getInstallmentDetails(params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetInstallmentDetails value)
        getInstallmentDetails,
  }) {
    return getInstallmentDetails(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetInstallmentDetails value)? getInstallmentDetails,
  }) {
    return getInstallmentDetails?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetInstallmentDetails value)? getInstallmentDetails,
    required TResult orElse(),
  }) {
    if (getInstallmentDetails != null) {
      return getInstallmentDetails(this);
    }
    return orElse();
  }
}

abstract class _GetInstallmentDetails implements InstallmentDetailsEvent {
  const factory _GetInstallmentDetails(final InstallmentDetailsParams params) =
      _$GetInstallmentDetailsImpl;

  @override
  InstallmentDetailsParams get params;

  /// Create a copy of InstallmentDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetInstallmentDetailsImplCopyWith<_$GetInstallmentDetailsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InstallmentDetailsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AppFailure error) loadFailure,
    required TResult Function() loading,
    required TResult Function(
            List<LoanDetailsEntity> installmentDetailsResponse)
        loadSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AppFailure error)? loadFailure,
    TResult? Function()? loading,
    TResult? Function(List<LoanDetailsEntity> installmentDetailsResponse)?
        loadSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AppFailure error)? loadFailure,
    TResult Function()? loading,
    TResult Function(List<LoanDetailsEntity> installmentDetailsResponse)?
        loadSuccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadFailure value) loadFailure,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadSuccess value) loadSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadFailure value)? loadFailure,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadSuccess value)? loadSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadFailure value)? loadFailure,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadSuccess value)? loadSuccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InstallmentDetailsStateCopyWith<$Res> {
  factory $InstallmentDetailsStateCopyWith(InstallmentDetailsState value,
          $Res Function(InstallmentDetailsState) then) =
      _$InstallmentDetailsStateCopyWithImpl<$Res, InstallmentDetailsState>;
}

/// @nodoc
class _$InstallmentDetailsStateCopyWithImpl<$Res,
        $Val extends InstallmentDetailsState>
    implements $InstallmentDetailsStateCopyWith<$Res> {
  _$InstallmentDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InstallmentDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$InstallmentDetailsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of InstallmentDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'InstallmentDetailsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AppFailure error) loadFailure,
    required TResult Function() loading,
    required TResult Function(
            List<LoanDetailsEntity> installmentDetailsResponse)
        loadSuccess,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AppFailure error)? loadFailure,
    TResult? Function()? loading,
    TResult? Function(List<LoanDetailsEntity> installmentDetailsResponse)?
        loadSuccess,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AppFailure error)? loadFailure,
    TResult Function()? loading,
    TResult Function(List<LoanDetailsEntity> installmentDetailsResponse)?
        loadSuccess,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadFailure value) loadFailure,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadSuccess value) loadSuccess,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadFailure value)? loadFailure,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadSuccess value)? loadSuccess,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadFailure value)? loadFailure,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadSuccess value)? loadSuccess,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements InstallmentDetailsState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadFailureImplCopyWith<$Res> {
  factory _$$LoadFailureImplCopyWith(
          _$LoadFailureImpl value, $Res Function(_$LoadFailureImpl) then) =
      __$$LoadFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppFailure error});

  $AppFailureCopyWith<$Res> get error;
}

/// @nodoc
class __$$LoadFailureImplCopyWithImpl<$Res>
    extends _$InstallmentDetailsStateCopyWithImpl<$Res, _$LoadFailureImpl>
    implements _$$LoadFailureImplCopyWith<$Res> {
  __$$LoadFailureImplCopyWithImpl(
      _$LoadFailureImpl _value, $Res Function(_$LoadFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of InstallmentDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$LoadFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AppFailure,
    ));
  }

  /// Create a copy of InstallmentDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppFailureCopyWith<$Res> get error {
    return $AppFailureCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc

class _$LoadFailureImpl implements _LoadFailure {
  const _$LoadFailureImpl(this.error);

  @override
  final AppFailure error;

  @override
  String toString() {
    return 'InstallmentDetailsState.loadFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of InstallmentDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadFailureImplCopyWith<_$LoadFailureImpl> get copyWith =>
      __$$LoadFailureImplCopyWithImpl<_$LoadFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AppFailure error) loadFailure,
    required TResult Function() loading,
    required TResult Function(
            List<LoanDetailsEntity> installmentDetailsResponse)
        loadSuccess,
  }) {
    return loadFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AppFailure error)? loadFailure,
    TResult? Function()? loading,
    TResult? Function(List<LoanDetailsEntity> installmentDetailsResponse)?
        loadSuccess,
  }) {
    return loadFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AppFailure error)? loadFailure,
    TResult Function()? loading,
    TResult Function(List<LoanDetailsEntity> installmentDetailsResponse)?
        loadSuccess,
    required TResult orElse(),
  }) {
    if (loadFailure != null) {
      return loadFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadFailure value) loadFailure,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadSuccess value) loadSuccess,
  }) {
    return loadFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadFailure value)? loadFailure,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadSuccess value)? loadSuccess,
  }) {
    return loadFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadFailure value)? loadFailure,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadSuccess value)? loadSuccess,
    required TResult orElse(),
  }) {
    if (loadFailure != null) {
      return loadFailure(this);
    }
    return orElse();
  }
}

abstract class _LoadFailure implements InstallmentDetailsState {
  const factory _LoadFailure(final AppFailure error) = _$LoadFailureImpl;

  AppFailure get error;

  /// Create a copy of InstallmentDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadFailureImplCopyWith<_$LoadFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$InstallmentDetailsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of InstallmentDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'InstallmentDetailsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AppFailure error) loadFailure,
    required TResult Function() loading,
    required TResult Function(
            List<LoanDetailsEntity> installmentDetailsResponse)
        loadSuccess,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AppFailure error)? loadFailure,
    TResult? Function()? loading,
    TResult? Function(List<LoanDetailsEntity> installmentDetailsResponse)?
        loadSuccess,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AppFailure error)? loadFailure,
    TResult Function()? loading,
    TResult Function(List<LoanDetailsEntity> installmentDetailsResponse)?
        loadSuccess,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadFailure value) loadFailure,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadSuccess value) loadSuccess,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadFailure value)? loadFailure,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadSuccess value)? loadSuccess,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadFailure value)? loadFailure,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadSuccess value)? loadSuccess,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements InstallmentDetailsState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadSuccessImplCopyWith<$Res> {
  factory _$$LoadSuccessImplCopyWith(
          _$LoadSuccessImpl value, $Res Function(_$LoadSuccessImpl) then) =
      __$$LoadSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<LoanDetailsEntity> installmentDetailsResponse});
}

/// @nodoc
class __$$LoadSuccessImplCopyWithImpl<$Res>
    extends _$InstallmentDetailsStateCopyWithImpl<$Res, _$LoadSuccessImpl>
    implements _$$LoadSuccessImplCopyWith<$Res> {
  __$$LoadSuccessImplCopyWithImpl(
      _$LoadSuccessImpl _value, $Res Function(_$LoadSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of InstallmentDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? installmentDetailsResponse = null,
  }) {
    return _then(_$LoadSuccessImpl(
      null == installmentDetailsResponse
          ? _value._installmentDetailsResponse
          : installmentDetailsResponse // ignore: cast_nullable_to_non_nullable
              as List<LoanDetailsEntity>,
    ));
  }
}

/// @nodoc

class _$LoadSuccessImpl implements _LoadSuccess {
  const _$LoadSuccessImpl(
      final List<LoanDetailsEntity> installmentDetailsResponse)
      : _installmentDetailsResponse = installmentDetailsResponse;

  final List<LoanDetailsEntity> _installmentDetailsResponse;
  @override
  List<LoanDetailsEntity> get installmentDetailsResponse {
    if (_installmentDetailsResponse is EqualUnmodifiableListView)
      return _installmentDetailsResponse;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_installmentDetailsResponse);
  }

  @override
  String toString() {
    return 'InstallmentDetailsState.loadSuccess(installmentDetailsResponse: $installmentDetailsResponse)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadSuccessImpl &&
            const DeepCollectionEquality().equals(
                other._installmentDetailsResponse,
                _installmentDetailsResponse));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_installmentDetailsResponse));

  /// Create a copy of InstallmentDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadSuccessImplCopyWith<_$LoadSuccessImpl> get copyWith =>
      __$$LoadSuccessImplCopyWithImpl<_$LoadSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AppFailure error) loadFailure,
    required TResult Function() loading,
    required TResult Function(
            List<LoanDetailsEntity> installmentDetailsResponse)
        loadSuccess,
  }) {
    return loadSuccess(installmentDetailsResponse);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AppFailure error)? loadFailure,
    TResult? Function()? loading,
    TResult? Function(List<LoanDetailsEntity> installmentDetailsResponse)?
        loadSuccess,
  }) {
    return loadSuccess?.call(installmentDetailsResponse);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AppFailure error)? loadFailure,
    TResult Function()? loading,
    TResult Function(List<LoanDetailsEntity> installmentDetailsResponse)?
        loadSuccess,
    required TResult orElse(),
  }) {
    if (loadSuccess != null) {
      return loadSuccess(installmentDetailsResponse);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadFailure value) loadFailure,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadSuccess value) loadSuccess,
  }) {
    return loadSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadFailure value)? loadFailure,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadSuccess value)? loadSuccess,
  }) {
    return loadSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadFailure value)? loadFailure,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadSuccess value)? loadSuccess,
    required TResult orElse(),
  }) {
    if (loadSuccess != null) {
      return loadSuccess(this);
    }
    return orElse();
  }
}

abstract class _LoadSuccess implements InstallmentDetailsState {
  const factory _LoadSuccess(
          final List<LoanDetailsEntity> installmentDetailsResponse) =
      _$LoadSuccessImpl;

  List<LoanDetailsEntity> get installmentDetailsResponse;

  /// Create a copy of InstallmentDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadSuccessImplCopyWith<_$LoadSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
