import 'package:test_flutter_project/domain/models/conversation_model.dart';

abstract class MessagesRemoteDataSource {
  void initSampleData(String userId);

  Future<void> saveConversations(List<ConversationModel> conversations);

  Future<List<ConversationModel>> loadConversations();

  ConversationModel getConversationById(String conversationId);

  ConversationModel getOrCreateConversationByOwnerId(String ownerId);

  void dispose();
}
