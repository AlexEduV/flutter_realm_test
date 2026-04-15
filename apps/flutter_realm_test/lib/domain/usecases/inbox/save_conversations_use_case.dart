import 'package:test_flutter_project/domain/usecases/usecase.dart';

import '../../models/conversation_model.dart';
import '../../repositories/inbox_repository.dart';

class SaveConversationsUseCase extends UseCaseWithParams<List<ConversationModel>, Future<void>> {
  final InboxRepository _inboxRepository;

  SaveConversationsUseCase(this._inboxRepository);

  @override
  Future<void> call(List<ConversationModel> params) {
    return _inboxRepository.saveConversations(params);
  }
}
