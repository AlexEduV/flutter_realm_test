import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/enums/message_status.dart';
import 'package:test_futter_project/domain/models/message_model.dart';
import 'package:test_futter_project/domain/models/owner_model.dart';

void main() {
  group('MessageModel', () {
    final sender = OwnerModel(id: 'owner1', name: 'Alice', linkedItemIds: []);
    final date = DateTime(2023, 1, 1, 12, 0, 0);

    test('constructor assigns values correctly', () {
      final message = MessageModel(sender, MessageStatus.sent, 'Hello', date);
      expect(message.sender, sender);
      expect(message.messageStatus, MessageStatus.sent);
      expect(message.text, 'Hello');
      expect(message.date, date);
    });

    test('equality and hashCode: identical objects', () {
      final m1 = MessageModel(sender, MessageStatus.sent, 'Hello', date);
      final m2 = MessageModel(sender, MessageStatus.sent, 'Hello', date);
      expect(m1, m2);
      expect(m1.hashCode, m2.hashCode);
    });

    test('equality and hashCode: different objects', () {
      final m1 = MessageModel(sender, MessageStatus.sent, 'Hello', date);
      final m2 = MessageModel(sender, MessageStatus.read, 'Hello', date);
      final m3 = MessageModel(sender, MessageStatus.sent, 'Hi', date);
      final m4 = MessageModel(sender, MessageStatus.sent, 'Hello', DateTime(2023, 1, 1, 13, 0, 0));
      expect(m1 == m2, isFalse);
      expect(m1 == m3, isFalse);
      expect(m1 == m4, isFalse);
      expect(m1.hashCode == m2.hashCode, isFalse);
      expect(m1.hashCode == m3.hashCode, isFalse);
      expect(m1.hashCode == m4.hashCode, isFalse);
    });
  });
}
