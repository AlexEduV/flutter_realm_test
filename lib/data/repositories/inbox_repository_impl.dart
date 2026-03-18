import 'package:test_futter_project/domain/data_sources/remote/messages_remote_data_source.dart';
import 'package:test_futter_project/domain/models/conversation_model.dart';
import 'package:test_futter_project/domain/repositories/inbox_repository.dart';

class InboxRepositoryImpl implements InboxRepository {
  final MessagesRemoteDataSource _messagesRemoteDataSource;

  InboxRepositoryImpl(this._messagesRemoteDataSource);

  @override
  Future<List<ConversationModel>> fetchConversations() {
    return _messagesRemoteDataSource.loadConversations();
  }

  @override
  ConversationModel getConversationById(String conversationId) {
    return _messagesRemoteDataSource.getConversationById(conversationId);
  }

  @override
  Future<void> saveConversations(List<ConversationModel> conversations) {
    return _messagesRemoteDataSource.saveConversations(conversations);
  }
}
