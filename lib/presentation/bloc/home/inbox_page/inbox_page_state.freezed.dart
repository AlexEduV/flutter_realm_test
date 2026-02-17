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

 List<MessageModel> get messages; bool get isLoading;
/// Create a copy of InboxPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InboxPageStateCopyWith<InboxPageState> get copyWith => _$InboxPageStateCopyWithImpl<InboxPageState>(this as InboxPageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InboxPageState&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(messages),isLoading);

@override
String toString() {
  return 'InboxPageState(messages: $messages, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $InboxPageStateCopyWith<$Res>  {
  factory $InboxPageStateCopyWith(InboxPageState value, $Res Function(InboxPageState) _then) = _$InboxPageStateCopyWithImpl;
@useResult
$Res call({
 List<MessageModel> messages, bool isLoading
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
@pragma('vm:prefer-inline') @override $Res call({Object? messages = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<MessageModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _InboxPageState implements InboxPageState {
  const _InboxPageState({final  List<MessageModel> messages = const [], this.isLoading = false}): _messages = messages;
  

 final  List<MessageModel> _messages;
@override@JsonKey() List<MessageModel> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey() final  bool isLoading;

/// Create a copy of InboxPageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InboxPageStateCopyWith<_InboxPageState> get copyWith => __$InboxPageStateCopyWithImpl<_InboxPageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InboxPageState&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages),isLoading);

@override
String toString() {
  return 'InboxPageState(messages: $messages, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$InboxPageStateCopyWith<$Res> implements $InboxPageStateCopyWith<$Res> {
  factory _$InboxPageStateCopyWith(_InboxPageState value, $Res Function(_InboxPageState) _then) = __$InboxPageStateCopyWithImpl;
@override @useResult
$Res call({
 List<MessageModel> messages, bool isLoading
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
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,Object? isLoading = null,}) {
  return _then(_InboxPageState(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<MessageModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
