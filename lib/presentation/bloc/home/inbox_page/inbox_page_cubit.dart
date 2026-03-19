import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/enums/message_status.dart';
import 'package:test_futter_project/domain/models/message_model.dart';
import 'package:test_futter_project/domain/usecases/inbox/fetch_conversations_use_case.dart';
import 'package:test_futter_project/domain/usecases/inbox/save_conversations_use_case.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_state.dart';

class InboxPageCubit extends Cubit<InboxPageState> {
  final FetchConversationsUseCase _fetchMessagesUseCase;
  final SaveConversationsUseCase _saveConversationsUseCase;

  InboxPageCubit(this._fetchMessagesUseCase, this._saveConversationsUseCase)
    : super(const InboxPageState());

  Future<void> init() async {
    final conversationsList = await _fetchMessagesUseCase.call();
    emit(state.copyWith(conversations: conversationsList));
  }

  Future<void> sendMessage(String? conversationId, MessageModel message) async {
    if (conversationId == null) return;

    final conversation = state.conversations.firstWhereOrNull(
      (c) => c.conversationId == conversationId,
    );
    if (conversation == null) return;

    final updatedConversation = conversation.copyWith(
      messages: [...conversation.messages, message],
    );

    final updatedConversations = state.conversations
        .map((c) => c.conversationId == conversationId ? updatedConversation : c)
        .toList();

    emit(state.copyWith(conversations: updatedConversations));

    //todo: save to local storage cache as well
    await _saveConversationsUseCase.call(updatedConversations);
  }

  Future<void> markMessageAsRead(String conversationId, int messageIndex) async {
    final conversation = state.conversations.firstWhereOrNull(
      (c) => c.conversationId == conversationId,
    );

    if (conversation == null) return;
    if (messageIndex < 0 || messageIndex >= conversation.messages.length) return;

    final updatedMessages = List<MessageModel>.from(conversation.messages);
    updatedMessages[messageIndex] = updatedMessages[messageIndex].copyWith(
      messageStatus: MessageStatus.read,
    );

    final updatedConversation = conversation.copyWith(messages: updatedMessages);

    final updatedConversations = state.conversations
        .map((c) => c.conversationId == conversationId ? updatedConversation : c)
        .toList();

    emit(state.copyWith(conversations: updatedConversations));

    //todo: this saves messages to the mock cloud, but per offline-first approach we also should cache messages to the local storage
    await _saveConversationsUseCase.call(updatedConversations);
  }
}
