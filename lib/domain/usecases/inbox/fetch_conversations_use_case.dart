import 'package:test_futter_project/domain/models/conversation_model.dart';
import 'package:test_futter_project/domain/repositories/inbox_repository.dart';

import '../usecase.dart';

class FetchConversationsUseCase extends UseCaseNoParams<Future<List<ConversationModel>>> {
  final InboxRepository inboxRepository;

  FetchConversationsUseCase(this.inboxRepository);

  @override
  Future<List<ConversationModel>> call() {
    return inboxRepository.fetchConversations();
  }
}
