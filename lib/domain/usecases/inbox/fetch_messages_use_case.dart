import 'package:test_futter_project/domain/data_sources/messages_service.dart';
import 'package:test_futter_project/domain/models/message_model.dart';

import '../usecase.dart';

class FetchMessagesUseCase extends UseCaseNoParams<Future<List<MessageModel>>> {
  final MessagesService messagesService;

  FetchMessagesUseCase(this.messagesService);

  @override
  Future<List<MessageModel>> call() async {
    return messagesService.fetchMessages();
  }
}
