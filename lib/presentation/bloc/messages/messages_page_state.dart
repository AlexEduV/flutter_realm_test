import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/gif_entity.dart';

part 'messages_page_state.freezed.dart';

@freezed
abstract class MessagesPageState with _$MessagesPageState {
  const factory MessagesPageState({
    @Default(false) bool isLoading,
    String? currentConversationId,
    @Default('') String currentMessageText,
    @Default('') String currentGifSearchText,
    @Default(false) bool areGifsLoading,
    @Default('') String latestQuery,
    @Default([]) List<GifEntity> gifsInSearch,
  }) = _MessagesPageState;
}
