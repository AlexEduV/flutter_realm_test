// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserDataState {
  UserEntity get user;
  bool get isLoading;
  bool get isUserAuthenticated;

  /// Create a copy of UserDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserDataStateCopyWith<UserDataState> get copyWith =>
      _$UserDataStateCopyWithImpl<UserDataState>(
          this as UserDataState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserDataState &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isUserAuthenticated, isUserAuthenticated) ||
                other.isUserAuthenticated == isUserAuthenticated));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, user, isLoading, isUserAuthenticated);

  @override
  String toString() {
    return 'UserDataState(user: $user, isLoading: $isLoading, isUserAuthenticated: $isUserAuthenticated)';
  }
}

/// @nodoc
abstract mixin class $UserDataStateCopyWith<$Res> {
  factory $UserDataStateCopyWith(
          UserDataState value, $Res Function(UserDataState) _then) =
      _$UserDataStateCopyWithImpl;
  @useResult
  $Res call({UserEntity user, bool isLoading, bool isUserAuthenticated});
}

/// @nodoc
class _$UserDataStateCopyWithImpl<$Res>
    implements $UserDataStateCopyWith<$Res> {
  _$UserDataStateCopyWithImpl(this._self, this._then);

  final UserDataState _self;
  final $Res Function(UserDataState) _then;

  /// Create a copy of UserDataState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? isLoading = null,
    Object? isUserAuthenticated = null,
  }) {
    return _then(_self.copyWith(
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isUserAuthenticated: null == isUserAuthenticated
          ? _self.isUserAuthenticated
          : isUserAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _UserDataState extends UserDataState {
  const _UserDataState(
      {required this.user,
      this.isLoading = false,
      this.isUserAuthenticated = false})
      : super._();

  @override
  final UserEntity user;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isUserAuthenticated;

  /// Create a copy of UserDataState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserDataStateCopyWith<_UserDataState> get copyWith =>
      __$UserDataStateCopyWithImpl<_UserDataState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserDataState &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isUserAuthenticated, isUserAuthenticated) ||
                other.isUserAuthenticated == isUserAuthenticated));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, user, isLoading, isUserAuthenticated);

  @override
  String toString() {
    return 'UserDataState(user: $user, isLoading: $isLoading, isUserAuthenticated: $isUserAuthenticated)';
  }
}

/// @nodoc
abstract mixin class _$UserDataStateCopyWith<$Res>
    implements $UserDataStateCopyWith<$Res> {
  factory _$UserDataStateCopyWith(
          _UserDataState value, $Res Function(_UserDataState) _then) =
      __$UserDataStateCopyWithImpl;
  @override
  @useResult
  $Res call({UserEntity user, bool isLoading, bool isUserAuthenticated});
}

/// @nodoc
class __$UserDataStateCopyWithImpl<$Res>
    implements _$UserDataStateCopyWith<$Res> {
  __$UserDataStateCopyWithImpl(this._self, this._then);

  final _UserDataState _self;
  final $Res Function(_UserDataState) _then;

  /// Create a copy of UserDataState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? user = null,
    Object? isLoading = null,
    Object? isUserAuthenticated = null,
  }) {
    return _then(_UserDataState(
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isUserAuthenticated: null == isUserAuthenticated
          ? _self.isUserAuthenticated
          : isUserAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
