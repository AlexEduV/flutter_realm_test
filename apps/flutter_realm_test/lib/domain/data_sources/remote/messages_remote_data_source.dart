import 'package:test_futter_project/domain/models/conversation_model.dart';

abstract class MessagesRemoteDataSource {
  Future<void> saveConversations(List<ConversationModel> conversations);

  Future<List<ConversationModel>> loadConversations();

  ConversationModel getConversationById(String conversationId);

  ConversationModel getConversationByOwnerId(String ownerId);

  void dispose();
}
