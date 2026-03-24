import 'package:test_futter_project/domain/models/conversation_model.dart';

abstract class InboxRepository {
  Future<List<ConversationModel>> fetchConversations();

  ConversationModel getConversationById(String conversationId);

  ConversationModel getConversationByOwnerId(String ownerId);

  Future<void> saveConversations(List<ConversationModel> conversations);
}
