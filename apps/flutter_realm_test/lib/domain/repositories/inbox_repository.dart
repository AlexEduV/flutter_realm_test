import 'package:test_flutter_project/domain/entities/conversation_entity.dart';

abstract interface class InboxRepository {
  Future<List<ConversationEntity>> fetchConversations();

  ConversationEntity getConversationById(String conversationId);

  ConversationEntity getConversationByOwnerId(String ownerId);

  Future<void> saveConversations(List<ConversationEntity> conversations);
}
