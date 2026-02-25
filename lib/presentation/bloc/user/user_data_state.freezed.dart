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

 bool get isLoading; bool get isLocationPermissionGranted; List<String> get favoriteIds; bool get isUserAuthenticated; String get firstName; String get lastName; String get email; String get password; Map<DateTime, CarEntity>? get lastSeenCar;
/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserDataStateCopyWith<UserDataState> get copyWith => _$UserDataStateCopyWithImpl<UserDataState>(this as UserDataState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserDataState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLocationPermissionGranted, isLocationPermissionGranted) || other.isLocationPermissionGranted == isLocationPermissionGranted)&&const DeepCollectionEquality().equals(other.favoriteIds, favoriteIds)&&(identical(other.isUserAuthenticated, isUserAuthenticated) || other.isUserAuthenticated == isUserAuthenticated)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&const DeepCollectionEquality().equals(other.lastSeenCar, lastSeenCar));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLocationPermissionGranted,const DeepCollectionEquality().hash(favoriteIds),isUserAuthenticated,firstName,lastName,email,password,const DeepCollectionEquality().hash(lastSeenCar));

@override
String toString() {
  return 'UserDataState(isLoading: $isLoading, isLocationPermissionGranted: $isLocationPermissionGranted, favoriteIds: $favoriteIds, isUserAuthenticated: $isUserAuthenticated, firstName: $firstName, lastName: $lastName, email: $email, password: $password, lastSeenCar: $lastSeenCar)';
}


}

/// @nodoc
abstract mixin class $UserDataStateCopyWith<$Res>  {
  factory $UserDataStateCopyWith(UserDataState value, $Res Function(UserDataState) _then) = _$UserDataStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isLocationPermissionGranted, List<String> favoriteIds, bool isUserAuthenticated, String firstName, String lastName, String email, String password, Map<DateTime, CarEntity>? lastSeenCar
});




}
/// @nodoc
class _$UserDataStateCopyWithImpl<$Res>
    implements $UserDataStateCopyWith<$Res> {
  _$UserDataStateCopyWithImpl(this._self, this._then);

  final UserDataState _self;
  final $Res Function(UserDataState) _then;

/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isLocationPermissionGranted = null,Object? favoriteIds = null,Object? isUserAuthenticated = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? password = null,Object? lastSeenCar = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLocationPermissionGranted: null == isLocationPermissionGranted ? _self.isLocationPermissionGranted : isLocationPermissionGranted // ignore: cast_nullable_to_non_nullable
as bool,favoriteIds: null == favoriteIds ? _self.favoriteIds : favoriteIds // ignore: cast_nullable_to_non_nullable
as List<String>,isUserAuthenticated: null == isUserAuthenticated ? _self.isUserAuthenticated : isUserAuthenticated // ignore: cast_nullable_to_non_nullable
as bool,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,lastSeenCar: freezed == lastSeenCar ? _self.lastSeenCar : lastSeenCar // ignore: cast_nullable_to_non_nullable
as Map<DateTime, CarEntity>?,
  ));
}

}


/// @nodoc


class _UserDataState implements UserDataState {
  const _UserDataState({this.isLoading = false, this.isLocationPermissionGranted = false, final  List<String> favoriteIds = const [], this.isUserAuthenticated = false, this.firstName = '', this.lastName = '', this.email = '', this.password = '', final  Map<DateTime, CarEntity>? lastSeenCar = null}): _favoriteIds = favoriteIds,_lastSeenCar = lastSeenCar;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLocationPermissionGranted;
 final  List<String> _favoriteIds;
@override@JsonKey() List<String> get favoriteIds {
  if (_favoriteIds is EqualUnmodifiableListView) return _favoriteIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoriteIds);
}

@override@JsonKey() final  bool isUserAuthenticated;
@override@JsonKey() final  String firstName;
@override@JsonKey() final  String lastName;
@override@JsonKey() final  String email;
@override@JsonKey() final  String password;
 final  Map<DateTime, CarEntity>? _lastSeenCar;
@override@JsonKey() Map<DateTime, CarEntity>? get lastSeenCar {
  final value = _lastSeenCar;
  if (value == null) return null;
  if (_lastSeenCar is EqualUnmodifiableMapView) return _lastSeenCar;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserDataStateCopyWith<_UserDataState> get copyWith => __$UserDataStateCopyWithImpl<_UserDataState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserDataState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLocationPermissionGranted, isLocationPermissionGranted) || other.isLocationPermissionGranted == isLocationPermissionGranted)&&const DeepCollectionEquality().equals(other._favoriteIds, _favoriteIds)&&(identical(other.isUserAuthenticated, isUserAuthenticated) || other.isUserAuthenticated == isUserAuthenticated)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&const DeepCollectionEquality().equals(other._lastSeenCar, _lastSeenCar));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLocationPermissionGranted,const DeepCollectionEquality().hash(_favoriteIds),isUserAuthenticated,firstName,lastName,email,password,const DeepCollectionEquality().hash(_lastSeenCar));

@override
String toString() {
  return 'UserDataState(isLoading: $isLoading, isLocationPermissionGranted: $isLocationPermissionGranted, favoriteIds: $favoriteIds, isUserAuthenticated: $isUserAuthenticated, firstName: $firstName, lastName: $lastName, email: $email, password: $password, lastSeenCar: $lastSeenCar)';
}


}

/// @nodoc
abstract mixin class _$UserDataStateCopyWith<$Res> implements $UserDataStateCopyWith<$Res> {
  factory _$UserDataStateCopyWith(_UserDataState value, $Res Function(_UserDataState) _then) = __$UserDataStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isLocationPermissionGranted, List<String> favoriteIds, bool isUserAuthenticated, String firstName, String lastName, String email, String password, Map<DateTime, CarEntity>? lastSeenCar
});




}
/// @nodoc
class __$UserDataStateCopyWithImpl<$Res>
    implements _$UserDataStateCopyWith<$Res> {
  __$UserDataStateCopyWithImpl(this._self, this._then);

  final _UserDataState _self;
  final $Res Function(_UserDataState) _then;

/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isLocationPermissionGranted = null,Object? favoriteIds = null,Object? isUserAuthenticated = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? password = null,Object? lastSeenCar = freezed,}) {
  return _then(_UserDataState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLocationPermissionGranted: null == isLocationPermissionGranted ? _self.isLocationPermissionGranted : isLocationPermissionGranted // ignore: cast_nullable_to_non_nullable
as bool,favoriteIds: null == favoriteIds ? _self._favoriteIds : favoriteIds // ignore: cast_nullable_to_non_nullable
as List<String>,isUserAuthenticated: null == isUserAuthenticated ? _self.isUserAuthenticated : isUserAuthenticated // ignore: cast_nullable_to_non_nullable
as bool,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,lastSeenCar: freezed == lastSeenCar ? _self._lastSeenCar : lastSeenCar // ignore: cast_nullable_to_non_nullable
as Map<DateTime, CarEntity>?,
  ));
}


}

// dart format on
