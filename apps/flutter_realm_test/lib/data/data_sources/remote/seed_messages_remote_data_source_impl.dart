import 'dart:convert';

import 'package:test_flutter_project/common/extensions/list_extension.dart';
import 'package:test_flutter_project/domain/data_sources/remote/base_remote_storage.dart';
import 'package:test_flutter_project/domain/data_sources/remote/messages_remote_data_source.dart';
import 'package:test_flutter_project/domain/models/conversation_model.dart';
import 'package:test_flutter_project/domain/models/message_model.dart';
import 'package:test_flutter_project/domain/services/time_service.dart';

import '../../../common/enums/message_status.dart';

class SeedMessagesRemoteDataSourceImpl implements MessagesRemoteDataSource {
  SeedMessagesRemoteDataSourceImpl(this._timeService, this._remoteStorage);

  List<ConversationModel> _conversationsList = [];
  final TimeService _timeService;
  final BaseRemoteStorage _remoteStorage;

  @override
  void initSampleData(String currentUserId) {
    final testDate = _timeService.now().subtract(const Duration(hours: 4));
    final testDateOlder = _timeService.now().subtract(const Duration(days: 2));

    _conversationsList = [
      ConversationModel(
        conversationId: '1',
        ownerId: '1',
        messages: [
          MessageModel(
            senderId: '1',
            messageStatus: MessageStatus.unknown,
            payload: 'Some Message here.',
            date: testDate,
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
            date: testDateOlder,
          ),
          MessageModel(
            senderId: '4',
            messageStatus: MessageStatus.sent,
            payload: 'Other message is here.',
            date: testDateOlder,
          ),
          MessageModel(
            senderId: currentUserId,
            messageStatus: MessageStatus.sent,
            payload: 'Hello there.',
            date: testDateOlder,
          ),
          MessageModel(
            senderId: currentUserId,
            messageStatus: MessageStatus.sent,
            payload: 'Hello there again.',
            date: testDateOlder,
          ),
        ],
      ),
    ];
  }

  @override
  Future<void> saveConversations(List<ConversationModel> conversations) async {
    _conversationsList = List.from(conversations);

    final conversationsJsonList = conversations.map((c) => c.toJson()).toList();
    await _remoteStorage.setString('mock_conversations', jsonEncode(conversationsJsonList));
  }

  @override
  Future<List<ConversationModel>> loadConversations() async {
    final usersJson = _remoteStorage.getString('mock_conversations');
    if (usersJson != null) {
      final decoded = jsonDecode(usersJson);

      if (decoded is! List) {
        await saveConversations(_conversationsList);
        return _conversationsList;
      }

      final conversations = decoded
          .map<ConversationModel>(
            (value) => ConversationModel.fromJson(value as Map<String, dynamic>),
          )
          .toList();

      _conversationsList = conversations;
      return conversations;
    }

    await saveConversations(_conversationsList);
    return _conversationsList;
  }

  @override
  ConversationModel getConversationById(String conversationId) {
    final conversationIndex = _conversationsList.indexWhereOrNull(
      (element) => element.conversationId == conversationId,
    );

    if (conversationIndex == null) {
      return ConversationModel.empty();
    }

    return _conversationsList[conversationIndex];
  }

  @override
  ConversationModel getOrCreateConversationByOwnerId(String ownerId) {
    final conversationIndex = _conversationsList.indexWhereOrNull(
      (element) => element.ownerId == ownerId,
    );

    if (conversationIndex == null) {
      final conversation = _getNewConversation(ownerId);
      _conversationsList.add(conversation);

      return conversation;
    }

    return _conversationsList[conversationIndex];
  }

  int _getMaxConversationId() {
    final maxId = _conversationsList
        .map((element) => int.tryParse(element.conversationId))
        .whereType<int>() // filters out nulls
        .fold<int>(1, (prev, curr) => (curr > prev ? curr : prev));

    return maxId;
  }

  ConversationModel _getNewConversation(String ownerId) {
    final newConversationId = _getMaxConversationId() + 1;
    final conversation = ConversationModel.empty().copyWith(
      conversationId: newConversationId.toString(),
      ownerId: ownerId,
    );

    return conversation;
  }

  @override
  void dispose() {
    _conversationsList.clear();
  }
}
