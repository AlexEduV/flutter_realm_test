import 'package:test_futter_project/domain/data_sources/remote/messages_remote_data_source.dart';
import 'package:test_futter_project/domain/models/message_model.dart';

import '../../../common/enums/message_status.dart';
import '../../../domain/models/owner_model.dart';

class MockMessagesRemoteDataSourceImpl implements MessagesRemoteDataSource {
  List<MessageModel> _list = [];

  @override
  Future<List<MessageModel>> fetchMessages() async {
    _list = [
      MessageModel(
        OwnerModel(id: '1', name: 'James Norrington', linkedItemIds: ['2']),
        MessageStatus.unknown,
        'Some Message here.',
        DateTime.now().subtract(const Duration(hours: 4)),
      ),
      MessageModel(
        OwnerModel(id: '4', name: 'Jennifer Williams', linkedItemIds: []),
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
