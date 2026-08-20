import 'package:test_flutter_project/domain/entities/conversation_entity.dart';
import 'package:test_flutter_project/domain/repositories/inbox_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class GetConversationByIdUseCase implements UseCaseWithParams<String, ConversationEntity> {
  GetConversationByIdUseCase(this._inboxRepository);

  final InboxRepository _inboxRepository;

  @override
  ConversationEntity call(String params) {
    return _inboxRepository.getConversationById(params);
  }
}
