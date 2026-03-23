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
  List<ConversationModel> _list = [
    ConversationModel(
      conversationId: '1',
      ownerId: '1',
      messages: [
        MessageModel(
          senderId: '1',
          messageStatus: MessageStatus.unknown,
          payload: 'Some Message here.',
          date: DateTime.now().subtract(const Duration(hours: 4)),
        ),
      ],
    ),
    ConversationModel(
      conversationId: '2',
      ownerId: '4',
      messages: [
        MessageModel(
          senderId: '4',
          messageStatus: MessageStatus.sent,
          payload: 'Some Message here.',
          date: DateTime.now().subtract(const Duration(days: 2)),
        ),
        MessageModel(
          senderId: '4',
          messageStatus: MessageStatus.sent,
          payload: 'Other message is here.',
          date: DateTime.now().subtract(const Duration(days: 2)),
        ),
        MessageModel(
          senderId: serviceLocator<UserDataCubit>().user.userId,
          messageStatus: MessageStatus.sent,
          payload: 'Hello there.',
          date: DateTime.now().subtract(const Duration(days: 2)),
        ),
        MessageModel(
          senderId: serviceLocator<UserDataCubit>().user.userId,
          messageStatus: MessageStatus.sent,
          payload: 'Hello there again.',
          date: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ],
    ),
  ];

  @override
  Future<void> saveConversations(List<ConversationModel> conversations) async {
    _list = conversations;

    final prefs = await SharedPreferences.getInstance();
    final conversationsJsonList = conversations.map((c) => c.toJson()).toList();
    await prefs.setString('mock_conversations', jsonEncode(conversationsJsonList));
  }

  @override
  Future<List<ConversationModel>> loadConversations() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('mock_conversations');
    if (usersJson != null) {
      final decoded = jsonDecode(usersJson);

      if (decoded is! List) {
        await saveConversations(_list);
        return _list;
      }

      final conversations = decoded
          .map<ConversationModel>(
            (value) => ConversationModel.fromJson(value as Map<String, dynamic>),
          )
          .toList();

      _list = conversations;
      return conversations;
    }

    await saveConversations(_list);
    return _list;
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

  @override
  ConversationModel getConversationByOwnerId(String ownerId) {
    final conversationIndex = _list.indexWhereOrNull((element) => element.ownerId == ownerId);

    if (conversationIndex == null) {
      final newConversationId = getMaxConversationId() + 1;
      final conversation = ConversationModel.empty().copyWith(
        conversationId: newConversationId.toString(),
        ownerId: ownerId,
      );

      list.add(conversation);
      return _list.last;
    }

    return _list[conversationIndex];
  }

  int getMaxConversationId() {
    final maxId = _list
        .map((element) => int.parse(element.conversationId))
        .whereType<int>() // filters out nulls
        .fold<int>(1, (prev, curr) => (curr > prev ? curr : prev));

    return maxId;
  }
}
