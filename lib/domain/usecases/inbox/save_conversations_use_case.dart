import 'package:test_futter_project/domain/usecases/usecase.dart';

import '../../models/conversation_model.dart';
import '../../repositories/inbox_repository.dart';

class SaveConversationsUseCase extends UseCaseWithParams<List<ConversationModel>, Future<void>> {
  final InboxRepository inboxRepository;

  SaveConversationsUseCase(this.inboxRepository);

  @override
  Future<void> call(List<ConversationModel> params) {
    return inboxRepository.saveConversations(params);
  }
}
