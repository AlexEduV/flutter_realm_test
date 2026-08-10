// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'messages_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessagesPageState {
  bool get isLoading;
  String? get currentConversationId;
  String get currentMessageText;
  String get currentGifSearchText;
  bool get areGifsLoading;
  String get latestQuery;
  ServerFailure? get networkError;
  List<GifEntity> get gifsInSearch;
  String? get selectedGif;

  /// Create a copy of MessagesPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessagesPageStateCopyWith<MessagesPageState> get copyWith =>
      _$MessagesPageStateCopyWithImpl<MessagesPageState>(
          this as MessagesPageState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessagesPageState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.currentConversationId, currentConversationId) ||
                other.currentConversationId == currentConversationId) &&
            (identical(other.currentMessageText, currentMessageText) ||
                other.currentMessageText == currentMessageText) &&
            (identical(other.currentGifSearchText, currentGifSearchText) ||
                other.currentGifSearchText == currentGifSearchText) &&
            (identical(other.areGifsLoading, areGifsLoading) ||
                other.areGifsLoading == areGifsLoading) &&
            (identical(other.latestQuery, latestQuery) ||
                other.latestQuery == latestQuery) &&
            (identical(other.networkError, networkError) ||
                other.networkError == networkError) &&
            const DeepCollectionEquality()
                .equals(other.gifsInSearch, gifsInSearch) &&
            (identical(other.selectedGif, selectedGif) ||
                other.selectedGif == selectedGif));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      currentConversationId,
      currentMessageText,
      currentGifSearchText,
      areGifsLoading,
      latestQuery,
      networkError,
      const DeepCollectionEquality().hash(gifsInSearch),
      selectedGif);

  @override
  String toString() {
    return 'MessagesPageState(isLoading: $isLoading, currentConversationId: $currentConversationId, currentMessageText: $currentMessageText, currentGifSearchText: $currentGifSearchText, areGifsLoading: $areGifsLoading, latestQuery: $latestQuery, networkError: $networkError, gifsInSearch: $gifsInSearch, selectedGif: $selectedGif)';
  }
}

/// @nodoc
abstract mixin class $MessagesPageStateCopyWith<$Res> {
  factory $MessagesPageStateCopyWith(
          MessagesPageState value, $Res Function(MessagesPageState) _then) =
      _$MessagesPageStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isLoading,
      String? currentConversationId,
      String currentMessageText,
      String currentGifSearchText,
      bool areGifsLoading,
      String latestQuery,
      ServerFailure? networkError,
      List<GifEntity> gifsInSearch,
      String? selectedGif});
}

/// @nodoc
class _$MessagesPageStateCopyWithImpl<$Res>
    implements $MessagesPageStateCopyWith<$Res> {
  _$MessagesPageStateCopyWithImpl(this._self, this._then);

  final MessagesPageState _self;
  final $Res Function(MessagesPageState) _then;

  /// Create a copy of MessagesPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? currentConversationId = freezed,
    Object? currentMessageText = null,
    Object? currentGifSearchText = null,
    Object? areGifsLoading = null,
    Object? latestQuery = null,
    Object? networkError = freezed,
    Object? gifsInSearch = null,
    Object? selectedGif = freezed,
  }) {
    return _then(_self.copyWith(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      currentConversationId: freezed == currentConversationId
          ? _self.currentConversationId
          : currentConversationId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentMessageText: null == currentMessageText
          ? _self.currentMessageText
          : currentMessageText // ignore: cast_nullable_to_non_nullable
              as String,
      currentGifSearchText: null == currentGifSearchText
          ? _self.currentGifSearchText
          : currentGifSearchText // ignore: cast_nullable_to_non_nullable
              as String,
      areGifsLoading: null == areGifsLoading
          ? _self.areGifsLoading
          : areGifsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      latestQuery: null == latestQuery
          ? _self.latestQuery
          : latestQuery // ignore: cast_nullable_to_non_nullable
              as String,
      networkError: freezed == networkError
          ? _self.networkError
          : networkError // ignore: cast_nullable_to_non_nullable
              as ServerFailure?,
      gifsInSearch: null == gifsInSearch
          ? _self.gifsInSearch
          : gifsInSearch // ignore: cast_nullable_to_non_nullable
              as List<GifEntity>,
      selectedGif: freezed == selectedGif
          ? _self.selectedGif
          : selectedGif // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _MessagesPageState implements MessagesPageState {
  const _MessagesPageState(
      {this.isLoading = false,
      this.currentConversationId,
      this.currentMessageText = '',
      this.currentGifSearchText = '',
      this.areGifsLoading = false,
      this.latestQuery = '',
      this.networkError,
      final List<GifEntity> gifsInSearch = const [],
      this.selectedGif})
      : _gifsInSearch = gifsInSearch;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? currentConversationId;
  @override
  @JsonKey()
  final String currentMessageText;
  @override
  @JsonKey()
  final String currentGifSearchText;
  @override
  @JsonKey()
  final bool areGifsLoading;
  @override
  @JsonKey()
  final String latestQuery;
  @override
  final ServerFailure? networkError;
  final List<GifEntity> _gifsInSearch;
  @override
  @JsonKey()
  List<GifEntity> get gifsInSearch {
    if (_gifsInSearch is EqualUnmodifiableListView) return _gifsInSearch;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_gifsInSearch);
  }

  @override
  final String? selectedGif;

  /// Create a copy of MessagesPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessagesPageStateCopyWith<_MessagesPageState> get copyWith =>
      __$MessagesPageStateCopyWithImpl<_MessagesPageState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessagesPageState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.currentConversationId, currentConversationId) ||
                other.currentConversationId == currentConversationId) &&
            (identical(other.currentMessageText, currentMessageText) ||
                other.currentMessageText == currentMessageText) &&
            (identical(other.currentGifSearchText, currentGifSearchText) ||
                other.currentGifSearchText == currentGifSearchText) &&
            (identical(other.areGifsLoading, areGifsLoading) ||
                other.areGifsLoading == areGifsLoading) &&
            (identical(other.latestQuery, latestQuery) ||
                other.latestQuery == latestQuery) &&
            (identical(other.networkError, networkError) ||
                other.networkError == networkError) &&
            const DeepCollectionEquality()
                .equals(other._gifsInSearch, _gifsInSearch) &&
            (identical(other.selectedGif, selectedGif) ||
                other.selectedGif == selectedGif));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      currentConversationId,
      currentMessageText,
      currentGifSearchText,
      areGifsLoading,
      latestQuery,
      networkError,
      const DeepCollectionEquality().hash(_gifsInSearch),
      selectedGif);

  @override
  String toString() {
    return 'MessagesPageState(isLoading: $isLoading, currentConversationId: $currentConversationId, currentMessageText: $currentMessageText, currentGifSearchText: $currentGifSearchText, areGifsLoading: $areGifsLoading, latestQuery: $latestQuery, networkError: $networkError, gifsInSearch: $gifsInSearch, selectedGif: $selectedGif)';
  }
}

/// @nodoc
abstract mixin class _$MessagesPageStateCopyWith<$Res>
    implements $MessagesPageStateCopyWith<$Res> {
  factory _$MessagesPageStateCopyWith(
          _MessagesPageState value, $Res Function(_MessagesPageState) _then) =
      __$MessagesPageStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      String? currentConversationId,
      String currentMessageText,
      String currentGifSearchText,
      bool areGifsLoading,
      String latestQuery,
      ServerFailure? networkError,
      List<GifEntity> gifsInSearch,
      String? selectedGif});
}

/// @nodoc
class __$MessagesPageStateCopyWithImpl<$Res>
    implements _$MessagesPageStateCopyWith<$Res> {
  __$MessagesPageStateCopyWithImpl(this._self, this._then);

  final _MessagesPageState _self;
  final $Res Function(_MessagesPageState) _then;

  /// Create a copy of MessagesPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? currentConversationId = freezed,
    Object? currentMessageText = null,
    Object? currentGifSearchText = null,
    Object? areGifsLoading = null,
    Object? latestQuery = null,
    Object? networkError = freezed,
    Object? gifsInSearch = null,
    Object? selectedGif = freezed,
  }) {
    return _then(_MessagesPageState(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      currentConversationId: freezed == currentConversationId
          ? _self.currentConversationId
          : currentConversationId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentMessageText: null == currentMessageText
          ? _self.currentMessageText
          : currentMessageText // ignore: cast_nullable_to_non_nullable
              as String,
      currentGifSearchText: null == currentGifSearchText
          ? _self.currentGifSearchText
          : currentGifSearchText // ignore: cast_nullable_to_non_nullable
              as String,
      areGifsLoading: null == areGifsLoading
          ? _self.areGifsLoading
          : areGifsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      latestQuery: null == latestQuery
          ? _self.latestQuery
          : latestQuery // ignore: cast_nullable_to_non_nullable
              as String,
      networkError: freezed == networkError
          ? _self.networkError
          : networkError // ignore: cast_nullable_to_non_nullable
              as ServerFailure?,
      gifsInSearch: null == gifsInSearch
          ? _self._gifsInSearch
          : gifsInSearch // ignore: cast_nullable_to_non_nullable
              as List<GifEntity>,
      selectedGif: freezed == selectedGif
          ? _self.selectedGif
          : selectedGif // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
