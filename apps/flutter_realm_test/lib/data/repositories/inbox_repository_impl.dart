import 'package:test_flutter_project/domain/data_sources/remote/messages_remote_data_source.dart';
import 'package:test_flutter_project/domain/entities/conversation_entity.dart';
import 'package:test_flutter_project/domain/repositories/inbox_repository.dart';

class InboxRepositoryImpl implements InboxRepository {
  InboxRepositoryImpl(this._messagesRemoteDataSource);

  final MessagesRemoteDataSource _messagesRemoteDataSource;

  @override
  Future<List<ConversationEntity>> fetchConversations() {
    return _messagesRemoteDataSource.loadConversations();
  }

  @override
  ConversationEntity getConversationById(String conversationId) {
    return _messagesRemoteDataSource.getConversationById(conversationId);
  }

  @override
  Future<void> saveConversations(List<ConversationEntity> conversations) {
    return _messagesRemoteDataSource.saveConversations(conversations);
  }

  @override
  ConversationEntity getConversationByOwnerId(String ownerId) {
    return _messagesRemoteDataSource.getOrCreateConversationByOwnerId(ownerId);
  }
}
