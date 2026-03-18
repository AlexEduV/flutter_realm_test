import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/extensions/list_extension.dart';
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

    final conversations = List.of(state.conversations);

    final conversationIndex = conversations.indexWhereOrNull(
      (element) => element.conversationId == conversationId,
    );

    if (conversationIndex == null) return;

    final oldConversation = conversations[conversationIndex];
    final updatedMessages = List<MessageModel>.from(oldConversation.messages)..add(message);

    final updatedConversation = oldConversation.copyWith(messages: updatedMessages);

    conversations[conversationIndex] = updatedConversation;

    emit(state.copyWith(conversations: conversations));

    //todo: this saves messages to the mock cloud, but per offline-first approach we also should cache messages to the local storage
    await _saveConversationsUseCase.call(conversations);
  }
}
