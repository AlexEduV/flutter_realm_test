// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArticlePageState {

 bool get isLoading; ArticleEntity? get article;
/// Create a copy of ArticlePageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticlePageStateCopyWith<ArticlePageState> get copyWith => _$ArticlePageStateCopyWithImpl<ArticlePageState>(this as ArticlePageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticlePageState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.article, article) || other.article == article));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,article);

@override
String toString() {
  return 'ArticlePageState(isLoading: $isLoading, article: $article)';
}


}

/// @nodoc
abstract mixin class $ArticlePageStateCopyWith<$Res>  {
  factory $ArticlePageStateCopyWith(ArticlePageState value, $Res Function(ArticlePageState) _then) = _$ArticlePageStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, ArticleEntity? article
});




}
/// @nodoc
class _$ArticlePageStateCopyWithImpl<$Res>
    implements $ArticlePageStateCopyWith<$Res> {
  _$ArticlePageStateCopyWithImpl(this._self, this._then);

  final ArticlePageState _self;
  final $Res Function(ArticlePageState) _then;

/// Create a copy of ArticlePageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? article = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,article: freezed == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as ArticleEntity?,
  ));
}

}


/// @nodoc


class _ArticlePageState implements ArticlePageState {
  const _ArticlePageState({this.isLoading = false, this.article});
  

@override@JsonKey() final  bool isLoading;
@override final  ArticleEntity? article;

/// Create a copy of ArticlePageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticlePageStateCopyWith<_ArticlePageState> get copyWith => __$ArticlePageStateCopyWithImpl<_ArticlePageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticlePageState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.article, article) || other.article == article));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,article);

@override
String toString() {
  return 'ArticlePageState(isLoading: $isLoading, article: $article)';
}


}

/// @nodoc
abstract mixin class _$ArticlePageStateCopyWith<$Res> implements $ArticlePageStateCopyWith<$Res> {
  factory _$ArticlePageStateCopyWith(_ArticlePageState value, $Res Function(_ArticlePageState) _then) = __$ArticlePageStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, ArticleEntity? article
});




}
/// @nodoc
class __$ArticlePageStateCopyWithImpl<$Res>
    implements _$ArticlePageStateCopyWith<$Res> {
  __$ArticlePageStateCopyWithImpl(this._self, this._then);

  final _ArticlePageState _self;
  final $Res Function(_ArticlePageState) _then;

/// Create a copy of ArticlePageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? article = freezed,}) {
  return _then(_ArticlePageState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,article: freezed == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as ArticleEntity?,
  ));
}


}

// dart format on
