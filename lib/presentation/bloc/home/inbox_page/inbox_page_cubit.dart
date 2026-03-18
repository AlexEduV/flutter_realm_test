import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/extensions/list_extension.dart';
import 'package:test_futter_project/domain/models/message_model.dart';
import 'package:test_futter_project/domain/usecases/inbox/fetch_messages_use_case.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_state.dart';

class InboxPageCubit extends Cubit<InboxPageState> {
  final FetchMessagesUseCase _fetchMessagesUseCase;

  InboxPageCubit(this._fetchMessagesUseCase) : super(const InboxPageState());

  Future<void> init() async {
    final conversationsList = await _fetchMessagesUseCase.call();
    emit(state.copyWith(conversations: conversationsList));
  }

  void sendMessage(String? conversationId, MessageModel message) {
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

    //todo: update message service data and cloud (shared preferences);
  }
}
