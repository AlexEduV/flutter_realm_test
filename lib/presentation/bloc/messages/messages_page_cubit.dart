import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/enums/message_type.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_state.dart';

class MessagesPageCubit extends Cubit<MessagesPageState> {
  MessagesPageCubit() : super(const MessagesPageState());

  void setCurrentConversationId(String conversationId) {
    emit(state.copyWith(currentConversationId: conversationId));
  }

  void updateMessageText(String newText) {
    emit(state.copyWith(currentMessageText: newText));
  }

  void toggleMessageType() {
    int currentIndex = state.selectedMessageType.index;

    // 2. Calculate next index using Modulo (%)
    // This ensures it wraps back to 0 when it hits the end
    int nextIndex = (currentIndex + 1) % MessageType.values.length;

    // 3. Emit the next value
    emit(state.copyWith(selectedMessageType: MessageType.values[nextIndex]));
  }
}
