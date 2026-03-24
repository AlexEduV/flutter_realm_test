import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/data_sources/remote/messages_remote_data_source.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/models/conversation_model.dart';
import 'package:test_futter_project/domain/repositories/inbox_repository.dart';
import 'package:test_futter_project/domain/usecases/users/get_user_by_id_use_case.dart';

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

  @override
  ConversationModel getConversationByOwnerId(String ownerId) {
    return _messagesRemoteDataSource.getConversationByOwnerId(ownerId);
  }

  @override
  Map<String, UserEntity?> extractUsersFromConversation(ConversationModel conversation) {
    final senderIds = conversation.messages.map((m) => m.senderId).toSet();

    final userMap = <String, UserEntity?>{
      for (final id in senderIds) id: serviceLocator<GetUserByIdUseCase>().call(id),
    };

    return userMap;
  }
}
