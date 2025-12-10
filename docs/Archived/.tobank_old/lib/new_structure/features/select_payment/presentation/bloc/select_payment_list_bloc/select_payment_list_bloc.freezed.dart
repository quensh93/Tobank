// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_payment_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectPaymentListEvent {
  DepositsListParams get params => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DepositsListParams params) getSelectPaymentList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DepositsListParams params)? getSelectPaymentList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DepositsListParams params)? getSelectPaymentList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetSelectPaymentList value) getSelectPaymentList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetSelectPaymentList value)? getSelectPaymentList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetSelectPaymentList value)? getSelectPaymentList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of SelectPaymentListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectPaymentListEventCopyWith<SelectPaymentListEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectPaymentListEventCopyWith<$Res> {
  factory $SelectPaymentListEventCopyWith(SelectPaymentListEvent value,
          $Res Function(SelectPaymentListEvent) then) =
      _$SelectPaymentListEventCopyWithImpl<$Res, SelectPaymentListEvent>;
  @useResult
  $Res call({DepositsListParams params});
}

/// @nodoc
class _$SelectPaymentListEventCopyWithImpl<$Res,
        $Val extends SelectPaymentListEvent>
    implements $SelectPaymentListEventCopyWith<$Res> {
  _$SelectPaymentListEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectPaymentListEvent
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
              as DepositsListParams,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetSelectPaymentListImplCopyWith<$Res>
    implements $SelectPaymentListEventCopyWith<$Res> {
  factory _$$GetSelectPaymentListImplCopyWith(_$GetSelectPaymentListImpl value,
          $Res Function(_$GetSelectPaymentListImpl) then) =
      __$$GetSelectPaymentListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DepositsListParams params});
}

/// @nodoc
class __$$GetSelectPaymentListImplCopyWithImpl<$Res>
    extends _$SelectPaymentListEventCopyWithImpl<$Res,
        _$GetSelectPaymentListImpl>
    implements _$$GetSelectPaymentListImplCopyWith<$Res> {
  __$$GetSelectPaymentListImplCopyWithImpl(_$GetSelectPaymentListImpl _value,
      $Res Function(_$GetSelectPaymentListImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectPaymentListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? params = null,
  }) {
    return _then(_$GetSelectPaymentListImpl(
      null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as DepositsListParams,
    ));
  }
}

/// @nodoc

class _$GetSelectPaymentListImpl implements _GetSelectPaymentList {
  const _$GetSelectPaymentListImpl(this.params);

  @override
  final DepositsListParams params;

  @override
  String toString() {
    return 'SelectPaymentListEvent.getSelectPaymentList(params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetSelectPaymentListImpl &&
            (identical(other.params, params) || other.params == params));
  }

  @override
  int get hashCode => Object.hash(runtimeType, params);

  /// Create a copy of SelectPaymentListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetSelectPaymentListImplCopyWith<_$GetSelectPaymentListImpl>
      get copyWith =>
          __$$GetSelectPaymentListImplCopyWithImpl<_$GetSelectPaymentListImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DepositsListParams params) getSelectPaymentList,
  }) {
    return getSelectPaymentList(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DepositsListParams params)? getSelectPaymentList,
  }) {
    return getSelectPaymentList?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DepositsListParams params)? getSelectPaymentList,
    required TResult orElse(),
  }) {
    if (getSelectPaymentList != null) {
      return getSelectPaymentList(params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetSelectPaymentList value) getSelectPaymentList,
  }) {
    return getSelectPaymentList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetSelectPaymentList value)? getSelectPaymentList,
  }) {
    return getSelectPaymentList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetSelectPaymentList value)? getSelectPaymentList,
    required TResult orElse(),
  }) {
    if (getSelectPaymentList != null) {
      return getSelectPaymentList(this);
    }
    return orElse();
  }
}

abstract class _GetSelectPaymentList implements SelectPaymentListEvent {
  const factory _GetSelectPaymentList(final DepositsListParams params) =
      _$GetSelectPaymentListImpl;

  @override
  DepositsListParams get params;

  /// Create a copy of SelectPaymentListEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetSelectPaymentListImplCopyWith<_$GetSelectPaymentListImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SelectPaymentListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AppFailure error) loadFailure,
    required TResult Function() loading,
    required TResult Function(
            List<DepositsListEntity> selectPaymentListResponse)
        loadSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AppFailure error)? loadFailure,
    TResult? Function()? loading,
    TResult? Function(List<DepositsListEntity> selectPaymentListResponse)?
        loadSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AppFailure error)? loadFailure,
    TResult Function()? loading,
    TResult Function(List<DepositsListEntity> selectPaymentListResponse)?
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
abstract class $SelectPaymentListStateCopyWith<$Res> {
  factory $SelectPaymentListStateCopyWith(SelectPaymentListState value,
          $Res Function(SelectPaymentListState) then) =
      _$SelectPaymentListStateCopyWithImpl<$Res, SelectPaymentListState>;
}

/// @nodoc
class _$SelectPaymentListStateCopyWithImpl<$Res,
        $Val extends SelectPaymentListState>
    implements $SelectPaymentListStateCopyWith<$Res> {
  _$SelectPaymentListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectPaymentListState
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
    extends _$SelectPaymentListStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectPaymentListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'SelectPaymentListState.initial()';
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
            List<DepositsListEntity> selectPaymentListResponse)
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
    TResult? Function(List<DepositsListEntity> selectPaymentListResponse)?
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
    TResult Function(List<DepositsListEntity> selectPaymentListResponse)?
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

abstract class _Initial implements SelectPaymentListState {
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
    extends _$SelectPaymentListStateCopyWithImpl<$Res, _$LoadFailureImpl>
    implements _$$LoadFailureImplCopyWith<$Res> {
  __$$LoadFailureImplCopyWithImpl(
      _$LoadFailureImpl _value, $Res Function(_$LoadFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectPaymentListState
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

  /// Create a copy of SelectPaymentListState
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
    return 'SelectPaymentListState.loadFailure(error: $error)';
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

  /// Create a copy of SelectPaymentListState
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
            List<DepositsListEntity> selectPaymentListResponse)
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
    TResult? Function(List<DepositsListEntity> selectPaymentListResponse)?
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
    TResult Function(List<DepositsListEntity> selectPaymentListResponse)?
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

abstract class _LoadFailure implements SelectPaymentListState {
  const factory _LoadFailure(final AppFailure error) = _$LoadFailureImpl;

  AppFailure get error;

  /// Create a copy of SelectPaymentListState
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
    extends _$SelectPaymentListStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectPaymentListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'SelectPaymentListState.loading()';
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
            List<DepositsListEntity> selectPaymentListResponse)
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
    TResult? Function(List<DepositsListEntity> selectPaymentListResponse)?
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
    TResult Function(List<DepositsListEntity> selectPaymentListResponse)?
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

abstract class _Loading implements SelectPaymentListState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadSuccessImplCopyWith<$Res> {
  factory _$$LoadSuccessImplCopyWith(
          _$LoadSuccessImpl value, $Res Function(_$LoadSuccessImpl) then) =
      __$$LoadSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<DepositsListEntity> selectPaymentListResponse});
}

/// @nodoc
class __$$LoadSuccessImplCopyWithImpl<$Res>
    extends _$SelectPaymentListStateCopyWithImpl<$Res, _$LoadSuccessImpl>
    implements _$$LoadSuccessImplCopyWith<$Res> {
  __$$LoadSuccessImplCopyWithImpl(
      _$LoadSuccessImpl _value, $Res Function(_$LoadSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectPaymentListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectPaymentListResponse = null,
  }) {
    return _then(_$LoadSuccessImpl(
      null == selectPaymentListResponse
          ? _value._selectPaymentListResponse
          : selectPaymentListResponse // ignore: cast_nullable_to_non_nullable
              as List<DepositsListEntity>,
    ));
  }
}

/// @nodoc

class _$LoadSuccessImpl implements _LoadSuccess {
  const _$LoadSuccessImpl(
      final List<DepositsListEntity> selectPaymentListResponse)
      : _selectPaymentListResponse = selectPaymentListResponse;

  final List<DepositsListEntity> _selectPaymentListResponse;
  @override
  List<DepositsListEntity> get selectPaymentListResponse {
    if (_selectPaymentListResponse is EqualUnmodifiableListView)
      return _selectPaymentListResponse;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectPaymentListResponse);
  }

  @override
  String toString() {
    return 'SelectPaymentListState.loadSuccess(selectPaymentListResponse: $selectPaymentListResponse)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadSuccessImpl &&
            const DeepCollectionEquality().equals(
                other._selectPaymentListResponse, _selectPaymentListResponse));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_selectPaymentListResponse));

  /// Create a copy of SelectPaymentListState
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
            List<DepositsListEntity> selectPaymentListResponse)
        loadSuccess,
  }) {
    return loadSuccess(selectPaymentListResponse);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AppFailure error)? loadFailure,
    TResult? Function()? loading,
    TResult? Function(List<DepositsListEntity> selectPaymentListResponse)?
        loadSuccess,
  }) {
    return loadSuccess?.call(selectPaymentListResponse);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AppFailure error)? loadFailure,
    TResult Function()? loading,
    TResult Function(List<DepositsListEntity> selectPaymentListResponse)?
        loadSuccess,
    required TResult orElse(),
  }) {
    if (loadSuccess != null) {
      return loadSuccess(selectPaymentListResponse);
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

abstract class _LoadSuccess implements SelectPaymentListState {
  const factory _LoadSuccess(
          final List<DepositsListEntity> selectPaymentListResponse) =
      _$LoadSuccessImpl;

  List<DepositsListEntity> get selectPaymentListResponse;

  /// Create a copy of SelectPaymentListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadSuccessImplCopyWith<_$LoadSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
