import 'package:test_futter_project/domain/data_sources/remote/messages_remote_data_source.dart';
import 'package:test_futter_project/domain/models/message_model.dart';

import '../usecase.dart';

class FetchMessagesUseCase extends UseCaseNoParams<Future<List<MessageModel>>> {
  final MessagesRemoteDataSource messagesService;

  //todo: there needs to be a repository
  FetchMessagesUseCase(this.messagesService);

  @override
  Future<List<MessageModel>> call() {
    return messagesService.fetchMessages();
  }
}
