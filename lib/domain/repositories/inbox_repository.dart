import 'package:test_futter_project/domain/models/conversation_model.dart';

import '../entities/user_entity.dart';

abstract class InboxRepository {
  Future<List<ConversationModel>> fetchConversations();

  ConversationModel getConversationById(String conversationId);

  ConversationModel getConversationByOwnerId(String ownerId);

  Map<String, UserEntity?> extractUsersFromConversation(ConversationModel conversation);

  Future<void> saveConversations(List<ConversationModel> conversations);
}
