import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/enums/message_status.dart';
import 'package:test_futter_project/domain/models/message_model.dart';

void main() {
  group('MessageModel', () {
    final now = DateTime.now();
    final model = MessageModel(
      senderId: 'user1',
      messageStatus: MessageStatus.sent,
      payload: 'Hello',
      date: now,
    );

    test('constructor and properties', () {
      expect(model.senderId, 'user1');
      expect(model.messageStatus, MessageStatus.sent);
      expect(model.payload, 'Hello');
      expect(model.date, now);
    });

    test('copyWith returns updated values', () {
      final copy = model.copyWith(
        senderId: 'user2',
        messageStatus: MessageStatus.read,
        payload: 'World',
        date: now.add(const Duration(minutes: 1)),
      );
      expect(copy.senderId, 'user2');
      expect(copy.messageStatus, MessageStatus.read);
      expect(copy.payload, 'World');
      expect(copy.date, now.add(const Duration(minutes: 1)));

      // Partial copy
      final partialCopy = model.copyWith(payload: 'Changed');
      expect(partialCopy.senderId, model.senderId);
      expect(partialCopy.messageStatus, model.messageStatus);
      expect(partialCopy.payload, 'Changed');
      expect(partialCopy.date, model.date);
    });

    test('toJson and fromJson', () {
      final json = model.toJson();
      expect(json['senderId'], 'user1');
      expect(json['messageStatus'], 'sent');
      expect(json['text'], 'Hello');
      expect(json['date'], now.toIso8601String());

      final fromJson = MessageModel.fromJson(json);
      expect(fromJson, model);
    });

    test('== and hashCode', () {
      final model2 = MessageModel(
        senderId: 'user1',
        messageStatus: MessageStatus.sent,
        payload: 'Hello',
        date: now,
      );
      final model3 = MessageModel(
        senderId: 'user2',
        messageStatus: MessageStatus.sent,
        payload: 'Hello',
        date: now,
      );
      expect(model, model2);
      expect(model.hashCode, model2.hashCode);
      expect(model == model3, false);
    });
  });
}
