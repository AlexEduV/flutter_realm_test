import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_futter_project/common/enums/message_type.dart';

part 'messages_page_state.freezed.dart';

@freezed
abstract class MessagesPageState with _$MessagesPageState {
  const factory MessagesPageState({
    @Default(false) bool isLoading,
    String? currentConversationId,
    @Default('') String currentMessageText,
    @Default(MessageType.text) MessageType selectedMessageType,
    @Default(false) bool areGifsLoading,
  }) = _MessagesPageState;
}
