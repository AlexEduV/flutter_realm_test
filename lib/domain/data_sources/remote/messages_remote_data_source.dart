import 'package:test_futter_project/domain/models/conversation_model.dart';
import 'package:test_futter_project/domain/models/message_model.dart';

abstract class MessagesRemoteDataSource {
  Future<List<ConversationModel>> fetchMessages();

  Future<ConversationModel> getConversationById(String conversationId);

  void addMessage(MessageModel message, String conversationId);

  void dispose();
}
