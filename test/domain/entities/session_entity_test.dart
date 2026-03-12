import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/domain/entities/session_entity.dart';

void main() {
  group('SessionEntity', () {
    test('constructor assigns values correctly', () {
      const session = SessionEntity(sessionId: 'sess123', userId: 'user456');
      expect(session.sessionId, 'sess123');
      expect(session.userId, 'user456');
    });

    test('equality and hashCode: identical objects', () {
      const s1 = SessionEntity(sessionId: 'sess123', userId: 'user456');
      const s2 = SessionEntity(sessionId: 'sess123', userId: 'user456');
      expect(s1, s2);
      expect(s1.hashCode, s2.hashCode);
    });

    test('equality and hashCode: different objects', () {
      const s1 = SessionEntity(sessionId: 'sess123', userId: 'user456');
      const s2 = SessionEntity(sessionId: 'sess789', userId: 'user456');
      expect(s1 == s2, isFalse);
      expect(s1.hashCode == s2.hashCode, isFalse);
    });
  });
}
