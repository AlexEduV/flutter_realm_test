import 'package:test_futter_project/domain/models/message_model.dart';
import 'package:test_futter_project/domain/repositories/inbox_repository.dart';

import '../usecase.dart';

class FetchMessagesUseCase extends UseCaseNoParams<Future<List<MessageModel>>> {
  final InboxRepository inboxRepository;

  FetchMessagesUseCase(this.inboxRepository);

  @override
  Future<List<MessageModel>> call() {
    return inboxRepository.fetchMessages();
  }
}
