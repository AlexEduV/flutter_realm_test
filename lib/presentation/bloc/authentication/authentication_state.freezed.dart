// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthenticationState {

 bool get isPasswordFieldObscure;
/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticationStateCopyWith<AuthenticationState> get copyWith => _$AuthenticationStateCopyWithImpl<AuthenticationState>(this as AuthenticationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationState&&(identical(other.isPasswordFieldObscure, isPasswordFieldObscure) || other.isPasswordFieldObscure == isPasswordFieldObscure));
}


@override
int get hashCode => Object.hash(runtimeType,isPasswordFieldObscure);

@override
String toString() {
  return 'AuthenticationState(isPasswordFieldObscure: $isPasswordFieldObscure)';
}


}

/// @nodoc
abstract mixin class $AuthenticationStateCopyWith<$Res>  {
  factory $AuthenticationStateCopyWith(AuthenticationState value, $Res Function(AuthenticationState) _then) = _$AuthenticationStateCopyWithImpl;
@useResult
$Res call({
 bool isPasswordFieldObscure
});




}
/// @nodoc
class _$AuthenticationStateCopyWithImpl<$Res>
    implements $AuthenticationStateCopyWith<$Res> {
  _$AuthenticationStateCopyWithImpl(this._self, this._then);

  final AuthenticationState _self;
  final $Res Function(AuthenticationState) _then;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isPasswordFieldObscure = null,}) {
  return _then(_self.copyWith(
isPasswordFieldObscure: null == isPasswordFieldObscure ? _self.isPasswordFieldObscure : isPasswordFieldObscure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _AuthenticationState implements AuthenticationState {
  const _AuthenticationState({this.isPasswordFieldObscure = false});
  

@override@JsonKey() final  bool isPasswordFieldObscure;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthenticationStateCopyWith<_AuthenticationState> get copyWith => __$AuthenticationStateCopyWithImpl<_AuthenticationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthenticationState&&(identical(other.isPasswordFieldObscure, isPasswordFieldObscure) || other.isPasswordFieldObscure == isPasswordFieldObscure));
}


@override
int get hashCode => Object.hash(runtimeType,isPasswordFieldObscure);

@override
String toString() {
  return 'AuthenticationState(isPasswordFieldObscure: $isPasswordFieldObscure)';
}


}

/// @nodoc
abstract mixin class _$AuthenticationStateCopyWith<$Res> implements $AuthenticationStateCopyWith<$Res> {
  factory _$AuthenticationStateCopyWith(_AuthenticationState value, $Res Function(_AuthenticationState) _then) = __$AuthenticationStateCopyWithImpl;
@override @useResult
$Res call({
 bool isPasswordFieldObscure
});




}
/// @nodoc
class __$AuthenticationStateCopyWithImpl<$Res>
    implements _$AuthenticationStateCopyWith<$Res> {
  __$AuthenticationStateCopyWithImpl(this._self, this._then);

  final _AuthenticationState _self;
  final $Res Function(_AuthenticationState) _then;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isPasswordFieldObscure = null,}) {
  return _then(_AuthenticationState(
isPasswordFieldObscure: null == isPasswordFieldObscure ? _self.isPasswordFieldObscure : isPasswordFieldObscure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
