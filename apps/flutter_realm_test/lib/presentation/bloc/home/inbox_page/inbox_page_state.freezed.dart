// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inbox_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InboxPageState {

 bool get isLoading; List<ConversationModel> get conversations;
/// Create a copy of InboxPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InboxPageStateCopyWith<InboxPageState> get copyWith => _$InboxPageStateCopyWithImpl<InboxPageState>(this as InboxPageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InboxPageState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.conversations, conversations));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(conversations));

@override
String toString() {
  return 'InboxPageState(isLoading: $isLoading, conversations: $conversations)';
}


}

/// @nodoc
abstract mixin class $InboxPageStateCopyWith<$Res>  {
  factory $InboxPageStateCopyWith(InboxPageState value, $Res Function(InboxPageState) _then) = _$InboxPageStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<ConversationModel> conversations
});




}
/// @nodoc
class _$InboxPageStateCopyWithImpl<$Res>
    implements $InboxPageStateCopyWith<$Res> {
  _$InboxPageStateCopyWithImpl(this._self, this._then);

  final InboxPageState _self;
  final $Res Function(InboxPageState) _then;

/// Create a copy of InboxPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? conversations = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,conversations: null == conversations ? _self.conversations : conversations // ignore: cast_nullable_to_non_nullable
as List<ConversationModel>,
  ));
}

}


/// @nodoc


class _InboxPageState implements InboxPageState {
  const _InboxPageState({this.isLoading = false, final  List<ConversationModel> conversations = const []}): _conversations = conversations;


@override@JsonKey() final  bool isLoading;
 final  List<ConversationModel> _conversations;
@override@JsonKey() List<ConversationModel> get conversations {
  if (_conversations is EqualUnmodifiableListView) return _conversations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conversations);
}


/// Create a copy of InboxPageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InboxPageStateCopyWith<_InboxPageState> get copyWith => __$InboxPageStateCopyWithImpl<_InboxPageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InboxPageState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._conversations, _conversations));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_conversations));

@override
String toString() {
  return 'InboxPageState(isLoading: $isLoading, conversations: $conversations)';
}


}

/// @nodoc
abstract mixin class _$InboxPageStateCopyWith<$Res> implements $InboxPageStateCopyWith<$Res> {
  factory _$InboxPageStateCopyWith(_InboxPageState value, $Res Function(_InboxPageState) _then) = __$InboxPageStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<ConversationModel> conversations
});




}
/// @nodoc
class __$InboxPageStateCopyWithImpl<$Res>
    implements _$InboxPageStateCopyWith<$Res> {
  __$InboxPageStateCopyWithImpl(this._self, this._then);

  final _InboxPageState _self;
  final $Res Function(_InboxPageState) _then;

/// Create a copy of InboxPageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? conversations = null,}) {
  return _then(_InboxPageState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,conversations: null == conversations ? _self._conversations : conversations // ignore: cast_nullable_to_non_nullable
as List<ConversationModel>,
  ));
}


}

// dart format on
