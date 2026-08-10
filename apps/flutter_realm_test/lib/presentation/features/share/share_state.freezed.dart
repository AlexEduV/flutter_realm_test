// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'share_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShareState {
  bool get isLoading;
  String? get error;

  /// Create a copy of ShareState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShareStateCopyWith<ShareState> get copyWith =>
      _$ShareStateCopyWithImpl<ShareState>(this as ShareState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShareState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, error);

  @override
  String toString() {
    return 'ShareState(isLoading: $isLoading, error: $error)';
  }
}

/// @nodoc
abstract mixin class $ShareStateCopyWith<$Res> {
  factory $ShareStateCopyWith(
          ShareState value, $Res Function(ShareState) _then) =
      _$ShareStateCopyWithImpl;
  @useResult
  $Res call({bool isLoading, String? error});
}

/// @nodoc
class _$ShareStateCopyWithImpl<$Res> implements $ShareStateCopyWith<$Res> {
  _$ShareStateCopyWithImpl(this._self, this._then);

  final ShareState _self;
  final $Res Function(ShareState) _then;

  /// Create a copy of ShareState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_self.copyWith(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _ShareState implements ShareState {
  const _ShareState({this.isLoading = false, this.error});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  /// Create a copy of ShareState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ShareStateCopyWith<_ShareState> get copyWith =>
      __$ShareStateCopyWithImpl<_ShareState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShareState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, error);

  @override
  String toString() {
    return 'ShareState(isLoading: $isLoading, error: $error)';
  }
}

/// @nodoc
abstract mixin class _$ShareStateCopyWith<$Res>
    implements $ShareStateCopyWith<$Res> {
  factory _$ShareStateCopyWith(
          _ShareState value, $Res Function(_ShareState) _then) =
      __$ShareStateCopyWithImpl;
  @override
  @useResult
  $Res call({bool isLoading, String? error});
}

/// @nodoc
class __$ShareStateCopyWithImpl<$Res> implements _$ShareStateCopyWith<$Res> {
  __$ShareStateCopyWithImpl(this._self, this._then);

  final _ShareState _self;
  final $Res Function(_ShareState) _then;

  /// Create a copy of ShareState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_ShareState(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
