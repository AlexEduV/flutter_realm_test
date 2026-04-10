import 'package:test_futter_project/domain/models/conversation_model.dart';
import 'package:test_futter_project/domain/repositories/inbox_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class GetConversationByOwnerIdUseCase implements UseCaseWithParams<String, ConversationModel> {
  GetConversationByOwnerIdUseCase(this._inboxRepository);

  final InboxRepository _inboxRepository;

  @override
  ConversationModel call(String params) {
    return _inboxRepository.getConversationByOwnerId(params);
  }
}
