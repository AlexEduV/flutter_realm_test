import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_futter_project/common/extensions/list_extension.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/data_sources/remote/messages_remote_data_source.dart';
import 'package:test_futter_project/domain/models/conversation_model.dart';
import 'package:test_futter_project/domain/models/message_model.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';

import '../../../common/enums/message_status.dart';

class MockMessagesRemoteDataSourceImpl implements MessagesRemoteDataSource {
  final List<ConversationModel> _list = [
    ConversationModel(
      conversationId: '1',
      ownerId: '1',
      messages: [
        MessageModel(
          '1',
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
          '4',
          MessageStatus.sent,
          'Some Message here.',
          DateTime.now().subtract(const Duration(days: 2)),
        ),
        MessageModel(
          '4',
          MessageStatus.sent,
          'Other message is here.',
          DateTime.now().subtract(const Duration(days: 2)),
        ),
        MessageModel(
          serviceLocator<UserDataCubit>().user.userId,
          MessageStatus.sent,
          'Hello there.',
          DateTime.now().subtract(const Duration(days: 2)),
        ),
        MessageModel(
          serviceLocator<UserDataCubit>().user.userId,
          MessageStatus.sent,
          'Hello there again.',
          DateTime.now().subtract(const Duration(days: 2)),
        ),
      ],
    ),
  ];

  @override
  Future<List<ConversationModel>> fetchMessages() async {
    return _list;
  }

  Future<void> saveConversations(List<ConversationModel> conversations) async {
    final prefs = await SharedPreferences.getInstance();
    final conversationsJsonList = conversations.map((c) => c.toJson()).toList();
    await prefs.setString('mock_conversations', jsonEncode(conversationsJsonList));
  }

  List<ConversationModel> get list => _list;

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
