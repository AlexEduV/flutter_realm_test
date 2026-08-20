import 'package:test_flutter_project/domain/entities/conversation_entity.dart';

abstract interface class MessagesRemoteDataSource {
  void initSampleData(String userId);

  Future<void> saveConversations(List<ConversationEntity> conversations);

  Future<List<ConversationEntity>> loadConversations();

  ConversationEntity getConversationById(String conversationId);

  ConversationEntity getOrCreateConversationByOwnerId(String ownerId);

  void dispose();
}
