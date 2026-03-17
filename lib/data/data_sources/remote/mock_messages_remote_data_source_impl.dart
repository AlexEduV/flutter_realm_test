import 'package:test_futter_project/common/extensions/list_extension.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/data_sources/remote/messages_remote_data_source.dart';
import 'package:test_futter_project/domain/models/conversation_model.dart';
import 'package:test_futter_project/domain/models/message_model.dart';
import 'package:test_futter_project/domain/usecases/owners/get_owner_by_id_use_case.dart';

import '../../../common/enums/message_status.dart';

class MockMessagesRemoteDataSourceImpl implements MessagesRemoteDataSource {
  List<ConversationModel> _list = [];

  @override
  Future<List<ConversationModel>> fetchMessages() async {
    _list = [
      ConversationModel(
        conversationId: '1',
        ownerId: '1',
        messages: [
          MessageModel(
            serviceLocator<GetOwnerByIdUseCase>().call('1'),
            MessageStatus.unknown,
            'Some Message here.',
            DateTime.now().subtract(const Duration(hours: 4)),
          ),
        ],
      ),
      ConversationModel(
        conversationId: '2',
        ownerId: '4',
        messages: [
          MessageModel(
            serviceLocator<GetOwnerByIdUseCase>().call('4'),
            MessageStatus.sent,
            'Some Message here.',
            DateTime.now().subtract(const Duration(days: 2)),
          ),
        ],
      ),
    ];

    return _list;
  }

  List<ConversationModel> get list => _list;

  @override
  void addMessage(MessageModel message, String conversationId) {
    final conversationIndex = _list.indexWhere(
      (element) => element.conversationId == conversationId,
    );
    _list[conversationIndex].messages.add(message);
  }

  @override
  void dispose() {
    _list.clear();
  }

  @override
  ConversationModel getConversationById(String conversationId) {
    final conversationIndex = _list.indexWhereOrNull(
      (element) => element.conversationId == conversationId,
    );

    if (conversationIndex == null) {
      return ConversationModel.empty();
    }

    return _list[conversationIndex];
  }
}
