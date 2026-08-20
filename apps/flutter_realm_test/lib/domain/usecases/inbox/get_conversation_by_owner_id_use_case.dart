import 'package:test_flutter_project/domain/entities/conversation_entity.dart';
import 'package:test_flutter_project/domain/repositories/inbox_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class GetConversationByOwnerIdUseCase implements UseCaseWithParams<String, ConversationEntity> {
  GetConversationByOwnerIdUseCase(this._inboxRepository);

  final InboxRepository _inboxRepository;

  @override
  ConversationEntity call(String params) {
    return _inboxRepository.getConversationByOwnerId(params);
  }
}
