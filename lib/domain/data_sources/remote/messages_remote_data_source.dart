import 'package:test_futter_project/domain/models/conversation_model.dart';

abstract class MessagesRemoteDataSource {
  Future<List<ConversationModel>> fetchMessages();

  ConversationModel getConversationById(String conversationId);

  void dispose();
}
