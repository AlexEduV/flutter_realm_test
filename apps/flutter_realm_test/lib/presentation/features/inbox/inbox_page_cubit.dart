import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/enums/message_status.dart';
import 'package:test_flutter_project/domain/entities/conversation_entity.dart';
import 'package:test_flutter_project/domain/models/message_model.dart';
import 'package:test_flutter_project/domain/services/time_service.dart';
import 'package:test_flutter_project/domain/usecases/inbox/fetch_conversations_use_case.dart';
import 'package:test_flutter_project/domain/usecases/inbox/get_unread_count_from_conversation_use_case.dart';
import 'package:test_flutter_project/domain/usecases/inbox/save_conversations_use_case.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_page_state.dart';

class InboxPageCubit extends Cubit<InboxPageState> {
  InboxPageCubit(
    this._timeService,
    this._fetchConversationsUseCase,
    this._saveConversationsUseCase,
    this._getUnreadCountFromConversationUseCase,
  ) : super(const InboxPageState());

  final TimeService _timeService;
  final FetchConversationsUseCase _fetchConversationsUseCase;
  final SaveConversationsUseCase _saveConversationsUseCase;
  final GetUnreadCountFromConversationUseCase _getUnreadCountFromConversationUseCase;

  Future<void> init() async {
    final conversationsList = await _fetchConversationsUseCase.call();
    emit(state.copyWith(conversations: conversationsList));
  }

  Future<void> sendMessage(String? conversationId, MessageModel message) async {
    if (conversationId == null) return;

    final stampedMessage = message.copyWith(date: _timeService.now());

    final conversation = state.conversations.firstWhereOrNull(
      (c) => c.conversationId == conversationId,
    );
    if (conversation == null) return;

    final updatedConversation = conversation.copyWith(
      messages: [...conversation.messages, stampedMessage],
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

  Future<void> deleteConversation(String conversationId) async {
    final updatedConversations = List<ConversationEntity>.from(state.conversations);
    updatedConversations.removeWhere((element) => element.conversationId == conversationId);

    emit(state.copyWith(conversations: updatedConversations));
    await _saveConversationsUseCase.call(updatedConversations);
  }

  int getUnreadCountFromConversation(ConversationEntity conversation) {
    final unreadCount = _getUnreadCountFromConversationUseCase.call(conversation);
    return unreadCount;
  }
}
