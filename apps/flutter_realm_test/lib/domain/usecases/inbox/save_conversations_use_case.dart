import 'package:test_flutter_project/domain/usecases/usecase.dart';

import '../../entities/conversation_entity.dart';
import '../../repositories/inbox_repository.dart';

class SaveConversationsUseCase extends UseCaseWithParams<List<ConversationEntity>, Future<void>> {
  SaveConversationsUseCase(this._inboxRepository);

  final InboxRepository _inboxRepository;

  @override
  Future<void> call(List<ConversationEntity> params) {
    return _inboxRepository.saveConversations(params);
  }
}
