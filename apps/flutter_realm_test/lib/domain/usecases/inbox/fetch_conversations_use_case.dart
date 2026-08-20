import 'package:test_flutter_project/domain/entities/conversation_entity.dart';
import 'package:test_flutter_project/domain/repositories/inbox_repository.dart';

import '../usecase.dart';

class FetchConversationsUseCase extends UseCaseNoParams<Future<List<ConversationEntity>>> {
  FetchConversationsUseCase(this._inboxRepository);

  final InboxRepository _inboxRepository;

  @override
  Future<List<ConversationEntity>> call() {
    return _inboxRepository.fetchConversations();
  }
}
