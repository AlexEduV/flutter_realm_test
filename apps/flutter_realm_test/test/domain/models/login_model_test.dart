import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/domain/models/login_model.dart';

void main() {
  group('LoginModel', () {
    test('constructor assigns values correctly', () {
      final model = LoginModel('user@example.com', 'password123');
      expect(model.email, 'user@example.com');
      expect(model.password, 'password123');
    });

    test('equality and hashCode: identical objects', () {
      final m1 = LoginModel('user@example.com', 'password123');
      final m2 = LoginModel('user@example.com', 'password123');
      expect(m1, m2);
      expect(m1.hashCode, m2.hashCode);
    });

    test('equality and hashCode: different objects', () {
      final m1 = LoginModel('user@example.com', 'password123');
      final m2 = LoginModel('user2@example.com', 'password123');
      final m3 = LoginModel('user@example.com', 'pass456');
      expect(m1 == m2, isFalse);
      expect(m1 == m3, isFalse);
      expect(m1.hashCode == m2.hashCode, isFalse);
      expect(m1.hashCode == m3.hashCode, isFalse);
    });
  });
}
