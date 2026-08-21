import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/common/enums/message_status.dart';
import 'package:test_flutter_project/domain/entities/conversation_entity.dart';
import 'package:test_flutter_project/domain/models/message_model.dart';
import 'package:test_flutter_project/domain/usecases/inbox/get_unread_count_from_conversation_use_case.dart';

void main() {
  late GetUnreadCountFromConversationUseCase useCase;

  setUp(() {
    useCase = GetUnreadCountFromConversationUseCase();
  });

  MessageModel message({required String senderId, required MessageStatus status}) {
    return MessageModel(
      senderId: senderId,
      messageStatus: status,
      payload: 'text',
      date: DateTime(2024),
    );
  }

  group('GetUnreadCountFromConversationUseCase', () {
    test('returns 0 when there are no messages', () {
      final conversation = ConversationEntity(conversationId: 'c1', ownerId: 'owner1', messages: []);

      expect(useCase(conversation), 0);
    });

    test('returns 0 when all messages are from other senders', () {
      final conversation = ConversationEntity(
        conversationId: 'c1',
        ownerId: 'owner1',
        messages: [
          message(senderId: 'other', status: MessageStatus.sent),
          message(senderId: 'other', status: MessageStatus.sent),
        ],
      );

      expect(useCase(conversation), 0);
    });

    test('returns 0 when owner messages are all read', () {
      final conversation = ConversationEntity(
        conversationId: 'c1',
        ownerId: 'owner1',
        messages: [
          message(senderId: 'owner1', status: MessageStatus.read),
          message(senderId: 'owner1', status: MessageStatus.read),
        ],
      );

      expect(useCase(conversation), 0);
    });

    test('returns 0 when owner messages have unknown status', () {
      final conversation = ConversationEntity(
        conversationId: 'c1',
        ownerId: 'owner1',
        messages: [
          message(senderId: 'owner1', status: MessageStatus.unknown),
        ],
      );

      expect(useCase(conversation), 0);
    });

    test('counts only owner messages with sent status', () {
      final conversation = ConversationEntity(
        conversationId: 'c1',
        ownerId: 'owner1',
        messages: [
          message(senderId: 'owner1', status: MessageStatus.sent),
          message(senderId: 'owner1', status: MessageStatus.sent),
          message(senderId: 'owner1', status: MessageStatus.read),
          message(senderId: 'other', status: MessageStatus.sent),
        ],
      );

      expect(useCase(conversation), 2);
    });

    test('returns correct count when all owner messages are sent', () {
      final conversation = ConversationEntity(
        conversationId: 'c1',
        ownerId: 'owner1',
        messages: [
          message(senderId: 'owner1', status: MessageStatus.sent),
          message(senderId: 'owner1', status: MessageStatus.sent),
          message(senderId: 'owner1', status: MessageStatus.sent),
        ],
      );

      expect(useCase(conversation), 3);
    });

    test('returns 0 for empty conversation via factory', () {
      expect(useCase(ConversationEntity.empty()), 0);
    });
  });
}
