// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchPageState {

 List<CarEntity> get results; CarType get currentSelectedType; bool get isLoading;
/// Create a copy of SearchPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchPageStateCopyWith<SearchPageState> get copyWith => _$SearchPageStateCopyWithImpl<SearchPageState>(this as SearchPageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchPageState&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.currentSelectedType, currentSelectedType) || other.currentSelectedType == currentSelectedType)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(results),currentSelectedType,isLoading);

@override
String toString() {
  return 'SearchPageState(results: $results, currentSelectedType: $currentSelectedType, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $SearchPageStateCopyWith<$Res>  {
  factory $SearchPageStateCopyWith(SearchPageState value, $Res Function(SearchPageState) _then) = _$SearchPageStateCopyWithImpl;
@useResult
$Res call({
 List<CarEntity> results, CarType currentSelectedType, bool isLoading
});




}
/// @nodoc
class _$SearchPageStateCopyWithImpl<$Res>
    implements $SearchPageStateCopyWith<$Res> {
  _$SearchPageStateCopyWithImpl(this._self, this._then);

  final SearchPageState _self;
  final $Res Function(SearchPageState) _then;

/// Create a copy of SearchPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? results = null,Object? currentSelectedType = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<CarEntity>,currentSelectedType: null == currentSelectedType ? _self.currentSelectedType : currentSelectedType // ignore: cast_nullable_to_non_nullable
as CarType,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _SearchPageState implements SearchPageState {
  const _SearchPageState({final  List<CarEntity> results = const [], this.currentSelectedType = CarType.car, this.isLoading = false}): _results = results;
  

 final  List<CarEntity> _results;
@override@JsonKey() List<CarEntity> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override@JsonKey() final  CarType currentSelectedType;
@override@JsonKey() final  bool isLoading;

/// Create a copy of SearchPageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchPageStateCopyWith<_SearchPageState> get copyWith => __$SearchPageStateCopyWithImpl<_SearchPageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchPageState&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.currentSelectedType, currentSelectedType) || other.currentSelectedType == currentSelectedType)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_results),currentSelectedType,isLoading);

@override
String toString() {
  return 'SearchPageState(results: $results, currentSelectedType: $currentSelectedType, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$SearchPageStateCopyWith<$Res> implements $SearchPageStateCopyWith<$Res> {
  factory _$SearchPageStateCopyWith(_SearchPageState value, $Res Function(_SearchPageState) _then) = __$SearchPageStateCopyWithImpl;
@override @useResult
$Res call({
 List<CarEntity> results, CarType currentSelectedType, bool isLoading
});




}
/// @nodoc
class __$SearchPageStateCopyWithImpl<$Res>
    implements _$SearchPageStateCopyWith<$Res> {
  __$SearchPageStateCopyWithImpl(this._self, this._then);

  final _SearchPageState _self;
  final $Res Function(_SearchPageState) _then;

/// Create a copy of SearchPageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? results = null,Object? currentSelectedType = null,Object? isLoading = null,}) {
  return _then(_SearchPageState(
results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<CarEntity>,currentSelectedType: null == currentSelectedType ? _self.currentSelectedType : currentSelectedType // ignore: cast_nullable_to_non_nullable
as CarType,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
