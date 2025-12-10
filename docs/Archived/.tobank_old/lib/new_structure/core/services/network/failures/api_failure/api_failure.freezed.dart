// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApiFailure {
  String get message => throw _privateConstructorUsedError;
  String? get apiMessage => throw _privateConstructorUsedError;
  Map<String, dynamic>? get response => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String message, String? apiMessage, Map<String, dynamic>? response)
        generic,
    required TResult Function(
            String message, String? apiMessage, Map<String, dynamic>? response)
        invalidToken,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String message, String? apiMessage, Map<String, dynamic>? response)?
        generic,
    TResult? Function(
            String message, String? apiMessage, Map<String, dynamic>? response)?
        invalidToken,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String message, String? apiMessage, Map<String, dynamic>? response)?
        generic,
    TResult Function(
            String message, String? apiMessage, Map<String, dynamic>? response)?
        invalidToken,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericApiFailure value) generic,
    required TResult Function(InvalidTokenFailure value) invalidToken,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenericApiFailure value)? generic,
    TResult? Function(InvalidTokenFailure value)? invalidToken,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericApiFailure value)? generic,
    TResult Function(InvalidTokenFailure value)? invalidToken,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ApiFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiFailureCopyWith<ApiFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiFailureCopyWith<$Res> {
  factory $ApiFailureCopyWith(
          ApiFailure value, $Res Function(ApiFailure) then) =
      _$ApiFailureCopyWithImpl<$Res, ApiFailure>;
  @useResult
  $Res call(
      {String message, String? apiMessage, Map<String, dynamic>? response});
}

/// @nodoc
class _$ApiFailureCopyWithImpl<$Res, $Val extends ApiFailure>
    implements $ApiFailureCopyWith<$Res> {
  _$ApiFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? apiMessage = freezed,
    Object? response = freezed,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      apiMessage: freezed == apiMessage
          ? _value.apiMessage
          : apiMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      response: freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GenericApiFailureImplCopyWith<$Res>
    implements $ApiFailureCopyWith<$Res> {
  factory _$$GenericApiFailureImplCopyWith(_$GenericApiFailureImpl value,
          $Res Function(_$GenericApiFailureImpl) then) =
      __$$GenericApiFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message, String? apiMessage, Map<String, dynamic>? response});
}

/// @nodoc
class __$$GenericApiFailureImplCopyWithImpl<$Res>
    extends _$ApiFailureCopyWithImpl<$Res, _$GenericApiFailureImpl>
    implements _$$GenericApiFailureImplCopyWith<$Res> {
  __$$GenericApiFailureImplCopyWithImpl(_$GenericApiFailureImpl _value,
      $Res Function(_$GenericApiFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? apiMessage = freezed,
    Object? response = freezed,
  }) {
    return _then(_$GenericApiFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      apiMessage: freezed == apiMessage
          ? _value.apiMessage
          : apiMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      response: freezed == response
          ? _value._response
          : response // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$GenericApiFailureImpl extends GenericApiFailure {
  const _$GenericApiFailureImpl(
      {required this.message,
      this.apiMessage,
      final Map<String, dynamic>? response})
      : _response = response,
        super._();

  @override
  final String message;
  @override
  final String? apiMessage;
  final Map<String, dynamic>? _response;
  @override
  Map<String, dynamic>? get response {
    final value = _response;
    if (value == null) return null;
    if (_response is EqualUnmodifiableMapView) return _response;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ApiFailure.generic(message: $message, apiMessage: $apiMessage, response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenericApiFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.apiMessage, apiMessage) ||
                other.apiMessage == apiMessage) &&
            const DeepCollectionEquality().equals(other._response, _response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, apiMessage,
      const DeepCollectionEquality().hash(_response));

  /// Create a copy of ApiFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GenericApiFailureImplCopyWith<_$GenericApiFailureImpl> get copyWith =>
      __$$GenericApiFailureImplCopyWithImpl<_$GenericApiFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String message, String? apiMessage, Map<String, dynamic>? response)
        generic,
    required TResult Function(
            String message, String? apiMessage, Map<String, dynamic>? response)
        invalidToken,
  }) {
    return generic(message, apiMessage, response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String message, String? apiMessage, Map<String, dynamic>? response)?
        generic,
    TResult? Function(
            String message, String? apiMessage, Map<String, dynamic>? response)?
        invalidToken,
  }) {
    return generic?.call(message, apiMessage, response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String message, String? apiMessage, Map<String, dynamic>? response)?
        generic,
    TResult Function(
            String message, String? apiMessage, Map<String, dynamic>? response)?
        invalidToken,
    required TResult orElse(),
  }) {
    if (generic != null) {
      return generic(message, apiMessage, response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericApiFailure value) generic,
    required TResult Function(InvalidTokenFailure value) invalidToken,
  }) {
    return generic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenericApiFailure value)? generic,
    TResult? Function(InvalidTokenFailure value)? invalidToken,
  }) {
    return generic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericApiFailure value)? generic,
    TResult Function(InvalidTokenFailure value)? invalidToken,
    required TResult orElse(),
  }) {
    if (generic != null) {
      return generic(this);
    }
    return orElse();
  }
}

abstract class GenericApiFailure extends ApiFailure {
  const factory GenericApiFailure(
      {required final String message,
      final String? apiMessage,
      final Map<String, dynamic>? response}) = _$GenericApiFailureImpl;
  const GenericApiFailure._() : super._();

  @override
  String get message;
  @override
  String? get apiMessage;
  @override
  Map<String, dynamic>? get response;

  /// Create a copy of ApiFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GenericApiFailureImplCopyWith<_$GenericApiFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvalidTokenFailureImplCopyWith<$Res>
    implements $ApiFailureCopyWith<$Res> {
  factory _$$InvalidTokenFailureImplCopyWith(_$InvalidTokenFailureImpl value,
          $Res Function(_$InvalidTokenFailureImpl) then) =
      __$$InvalidTokenFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message, String? apiMessage, Map<String, dynamic>? response});
}

/// @nodoc
class __$$InvalidTokenFailureImplCopyWithImpl<$Res>
    extends _$ApiFailureCopyWithImpl<$Res, _$InvalidTokenFailureImpl>
    implements _$$InvalidTokenFailureImplCopyWith<$Res> {
  __$$InvalidTokenFailureImplCopyWithImpl(_$InvalidTokenFailureImpl _value,
      $Res Function(_$InvalidTokenFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? apiMessage = freezed,
    Object? response = freezed,
  }) {
    return _then(_$InvalidTokenFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      apiMessage: freezed == apiMessage
          ? _value.apiMessage
          : apiMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      response: freezed == response
          ? _value._response
          : response // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$InvalidTokenFailureImpl extends InvalidTokenFailure {
  const _$InvalidTokenFailureImpl(
      {this.message = 'Given token not valid for any token type',
      this.apiMessage,
      final Map<String, dynamic>? response})
      : _response = response,
        super._();

  @override
  @JsonKey()
  final String message;
  @override
  final String? apiMessage;
  final Map<String, dynamic>? _response;
  @override
  Map<String, dynamic>? get response {
    final value = _response;
    if (value == null) return null;
    if (_response is EqualUnmodifiableMapView) return _response;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ApiFailure.invalidToken(message: $message, apiMessage: $apiMessage, response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidTokenFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.apiMessage, apiMessage) ||
                other.apiMessage == apiMessage) &&
            const DeepCollectionEquality().equals(other._response, _response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, apiMessage,
      const DeepCollectionEquality().hash(_response));

  /// Create a copy of ApiFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvalidTokenFailureImplCopyWith<_$InvalidTokenFailureImpl> get copyWith =>
      __$$InvalidTokenFailureImplCopyWithImpl<_$InvalidTokenFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String message, String? apiMessage, Map<String, dynamic>? response)
        generic,
    required TResult Function(
            String message, String? apiMessage, Map<String, dynamic>? response)
        invalidToken,
  }) {
    return invalidToken(message, apiMessage, response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String message, String? apiMessage, Map<String, dynamic>? response)?
        generic,
    TResult? Function(
            String message, String? apiMessage, Map<String, dynamic>? response)?
        invalidToken,
  }) {
    return invalidToken?.call(message, apiMessage, response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String message, String? apiMessage, Map<String, dynamic>? response)?
        generic,
    TResult Function(
            String message, String? apiMessage, Map<String, dynamic>? response)?
        invalidToken,
    required TResult orElse(),
  }) {
    if (invalidToken != null) {
      return invalidToken(message, apiMessage, response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericApiFailure value) generic,
    required TResult Function(InvalidTokenFailure value) invalidToken,
  }) {
    return invalidToken(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenericApiFailure value)? generic,
    TResult? Function(InvalidTokenFailure value)? invalidToken,
  }) {
    return invalidToken?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericApiFailure value)? generic,
    TResult Function(InvalidTokenFailure value)? invalidToken,
    required TResult orElse(),
  }) {
    if (invalidToken != null) {
      return invalidToken(this);
    }
    return orElse();
  }
}

abstract class InvalidTokenFailure extends ApiFailure {
  const factory InvalidTokenFailure(
      {final String message,
      final String? apiMessage,
      final Map<String, dynamic>? response}) = _$InvalidTokenFailureImpl;
  const InvalidTokenFailure._() : super._();

  @override
  String get message;
  @override
  String? get apiMessage;
  @override
  Map<String, dynamic>? get response;

  /// Create a copy of ApiFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvalidTokenFailureImplCopyWith<_$InvalidTokenFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
