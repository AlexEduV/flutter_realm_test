import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/enums/message_status.dart';
import 'package:test_futter_project/domain/models/conversation_model.dart';
import 'package:test_futter_project/domain/models/message_model.dart';

void main() {
  group('ConversationModel', () {
    final date1 = DateTime.now();
    final date2 = DateTime.now();

    final messages = [
      MessageModel(senderId: '1', messageStatus: MessageStatus.sent, payload: 'Hello', date: date1),
      MessageModel(senderId: '1', messageStatus: MessageStatus.sent, payload: 'World', date: date2),
    ];

    test('constructor and properties', () {
      final model = ConversationModel(conversationId: 'c1', ownerId: 'o1', messages: messages);
      expect(model.conversationId, 'c1');
      expect(model.ownerId, 'o1');
      expect(model.messages, messages);
    });

    test('empty factory', () {
      final empty = ConversationModel.empty();
      expect(empty.conversationId, '');
      expect(empty.ownerId, '');
      expect(empty.messages, []);
    });

    test('copyWith returns updated values', () {
      final model = ConversationModel(conversationId: 'c1', ownerId: 'o1', messages: messages);
      final copy = model.copyWith(conversationId: 'c2', ownerId: 'o2');
      expect(copy.conversationId, 'c2');
      expect(copy.ownerId, 'o2');
      expect(copy.messages, messages);

      final copyMessages = model.copyWith(messages: []);
      expect(copyMessages.messages, []);
    });

    test('toJson and fromJson', () {
      final model = ConversationModel(conversationId: 'c1', ownerId: 'o1', messages: messages);
      final json = model.toJson();
      expect(json['conversationId'], 'c1');
      expect(json['ownerId'], 'o1');
      expect(json['messages'], [
        {
          'senderId': '1',
          'messageStatus': MessageStatus.sent.name,
          'text': 'Hello',
          'date': date1.toIso8601String(),
        },
        {
          'senderId': '1',
          'messageStatus': MessageStatus.sent.name,
          'text': 'World',
          'date': date2.toIso8601String(),
        },
      ]);

      // Adapt fromJson to use TestMessageModel
      final fromJsonModel = ConversationModel(
        conversationId: json['conversationId'] as String,
        ownerId: json['ownerId'] as String,
        messages: (json['messages'] as List<dynamic>)
            .map((m) => MessageModel.fromJson(m as Map<String, dynamic>))
            .toList(),
      );
      expect(fromJsonModel, model);
    });

    test('== and hashCode', () {
      final model1 = ConversationModel(conversationId: 'c1', ownerId: 'o1', messages: messages);
      final model2 = ConversationModel(conversationId: 'c1', ownerId: 'o1', messages: messages);
      final model3 = ConversationModel(conversationId: 'c2', ownerId: 'o1', messages: messages);
      expect(model1, model2);
      expect(model1.hashCode, model2.hashCode);
      expect(model1 == model3, false);
    });

    test('toJson returns correct map', () {
      // Arrange
      final conversation = ConversationModel(
        conversationId: 'c1',
        ownerId: 'u1',
        messages: messages,
      );

      // Act
      final json = conversation.toJson();

      // Assert
      expect(json, {
        'conversationId': 'c1',
        'ownerId': 'u1',
        'messages': [
          {
            'senderId': '1',
            'messageStatus': 'sent',
            'text': 'Hello',
            'date': date1.toIso8601String(),
          },
          {
            'senderId': '1',
            'messageStatus': 'sent',
            'text': 'World',
            'date': date2.toIso8601String(),
          },
        ],
      });
    });

    test('toJson returns correct map for empty conversation', () {
      // Arrange
      final conversation = ConversationModel.empty();

      // Act
      final json = conversation.toJson();

      // Assert
      expect(json, {'conversationId': '', 'ownerId': '', 'messages': []});
    });

    test('should correctly parse from JSON', () {
      // Arrange
      final json = {
        'conversationId': 'conv1',
        'ownerId': 'owner1',
        'messages': [
          {'senderId': 'user1', 'text': 'Hello', 'date': '1234567890', 'messageStatus': 'read'},
          {'senderId': 'user2', 'text': 'Hi!', 'date': '1234567891', 'messageStatus': 'read'},
        ],
      };

      // Act
      final model = ConversationModel.fromJson(json);

      // Assert
      expect(model.conversationId, 'conv1');
      expect(model.ownerId, 'owner1');
      expect(model.messages.length, 2);
      expect(model.messages[0], isA<MessageModel>());
      expect(model.messages[0].senderId, 'user1');
      expect(model.messages[0].payload, 'Hello');
      expect(model.messages[1].senderId, 'user2');
      expect(model.messages[1].payload, 'Hi!');
    });
  });
}
