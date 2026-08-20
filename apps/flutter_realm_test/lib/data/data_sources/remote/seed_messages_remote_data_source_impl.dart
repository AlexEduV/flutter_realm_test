import 'dart:convert';

import 'package:test_flutter_project/common/extensions/list_extension.dart';
import 'package:test_flutter_project/domain/data_sources/remote/app_remote_storage.dart';
import 'package:test_flutter_project/domain/data_sources/remote/messages_remote_data_source.dart';
import 'package:test_flutter_project/domain/entities/conversation_entity.dart';
import 'package:test_flutter_project/domain/models/message_model.dart';
import 'package:test_flutter_project/domain/services/time_service.dart';

import '../../../common/enums/message_status.dart';

class SeedMessagesRemoteDataSourceImpl implements MessagesRemoteDataSource {
  SeedMessagesRemoteDataSourceImpl(this._timeService, this._remoteStorage);

  List<ConversationEntity> _conversationsList = [];
  final TimeService _timeService;
  final AppRemoteStorage _remoteStorage;

  @override
  void initSampleData(String currentUserId) {
    final testDate = _timeService.now().subtract(const Duration(hours: 4));
    final testDateOlder = _timeService.now().subtract(const Duration(days: 2));

    _conversationsList = [
      ConversationEntity(
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
      ConversationEntity(
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
  Future<void> saveConversations(List<ConversationEntity> conversations) async {
    _conversationsList = List.from(conversations);

    final conversationsJsonList = conversations.map((c) => c.toJson()).toList();
    await _remoteStorage.setString('mock_conversations', jsonEncode(conversationsJsonList));
  }

  @override
  Future<List<ConversationEntity>> loadConversations() async {
    final usersJson = await _remoteStorage.getString('mock_conversations');
    if (usersJson != null) {
      final decoded = jsonDecode(usersJson);

      if (decoded is! List) {
        await saveConversations(_conversationsList);
        return _conversationsList;
      }

      final conversations = decoded
          .map<ConversationEntity>(
            (value) => ConversationEntity.fromJson(value as Map<String, dynamic>),
          )
          .toList();

      _conversationsList = conversations;
      return conversations;
    }

    await saveConversations(_conversationsList);
    return _conversationsList;
  }

  @override
  ConversationEntity getConversationById(String conversationId) {
    final conversationIndex = _conversationsList.indexWhereOrNull(
      (element) => element.conversationId == conversationId,
    );

    if (conversationIndex == null) {
      return ConversationEntity.empty();
    }

    return _conversationsList[conversationIndex];
  }

  @override
  ConversationEntity getOrCreateConversationByOwnerId(String ownerId) {
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

  ConversationEntity _getNewConversation(String ownerId) {
    final newConversationId = _getMaxConversationId() + 1;
    final conversation = ConversationEntity.empty().copyWith(
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
