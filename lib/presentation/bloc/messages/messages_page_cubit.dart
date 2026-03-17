import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_state.dart';

class MessagesPageCubit extends Cubit<MessagesPageState> {
  MessagesPageCubit() : super(const MessagesPageState());

  void setCurrentConversationId(String conversationId) {
    emit(state.copyWith(currentConversationId: conversationId));
  }

  void updateMessageText(String newText) {
    emit(state.copyWith(currentMessageText: newText));
  }
}
