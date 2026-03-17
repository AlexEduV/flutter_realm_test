import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_futter_project/domain/models/conversation_model.dart';

part 'messages_page_state.freezed.dart';

@freezed
abstract class MessagesPageState with _$MessagesPageState {
  const factory MessagesPageState({@Default(false) bool isLoading, String? currentConversationId}) =
      _MessagesPageState;
}
