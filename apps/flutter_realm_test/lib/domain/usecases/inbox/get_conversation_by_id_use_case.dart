import 'package:test_flutter_project/domain/models/conversation_model.dart';
import 'package:test_flutter_project/domain/repositories/inbox_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class GetConversationByIdUseCase implements UseCaseWithParams<String, ConversationModel> {
  GetConversationByIdUseCase(this._inboxRepository);

  final InboxRepository _inboxRepository;

  @override
  ConversationModel call(String params) {
    return _inboxRepository.getConversationById(params);
  }
}
