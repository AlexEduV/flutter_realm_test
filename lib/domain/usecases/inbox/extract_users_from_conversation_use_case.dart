import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/models/conversation_model.dart';
import 'package:test_futter_project/domain/repositories/inbox_repository.dart';

import '../usecase.dart';

class ExtractUsersFromConversationUseCase
    extends UseCaseWithParams<ConversationModel, Map<String, UserEntity?>> {
  final InboxRepository inboxRepository;

  ExtractUsersFromConversationUseCase(this.inboxRepository);

  @override
  Map<String, UserEntity?> call(ConversationModel conversation) {
    return inboxRepository.extractUsersFromConversation(conversation);
  }
}
