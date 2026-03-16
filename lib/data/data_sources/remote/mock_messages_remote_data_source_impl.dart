import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/data_sources/remote/messages_remote_data_source.dart';
import 'package:test_futter_project/domain/models/message_model.dart';
import 'package:test_futter_project/domain/usecases/owners/get_owner_by_id_use_case.dart';

import '../../../common/enums/message_status.dart';

class MockMessagesRemoteDataSourceImpl implements MessagesRemoteDataSource {
  List<MessageModel> _list = [];

  @override
  Future<List<MessageModel>> fetchMessages() async {
    _list = [
      MessageModel(
        serviceLocator<GetOwnerByIdUseCase>().call('1'),
        MessageStatus.unknown,
        'Some Message here.',
        DateTime.now().subtract(const Duration(hours: 4)),
      ),
      MessageModel(
        serviceLocator<GetOwnerByIdUseCase>().call('4'),
        MessageStatus.sent,
        'Some Message here.',
        DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];

    return _list;
  }

  List<MessageModel> get list => _list;

  @override
  void addMessage(MessageModel message) {
    _list.add(message);
  }

  @override
  void dispose() {
    _list.clear();
  }
}
