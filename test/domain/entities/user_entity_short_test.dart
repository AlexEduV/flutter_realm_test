import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/domain/entities/user_entity_short.dart';

void main() {
  group('UserEntityShort', () {
    const user = UserEntityShort(
      userId: 'u123',
      email: 'test@example.com',
      password: 'secret',
      firstName: 'John',
      lastName: 'Doe',
      region: 'uk',
      avatarImageSrc: null,
    );

    test('constructor assigns properties correctly', () {
      expect(user.userId, 'u123');
      expect(user.email, 'test@example.com');
      expect(user.password, 'secret');
      expect(user.firstName, 'John');
      expect(user.lastName, 'Doe');
      expect(user.region, 'uk');
    });

    test('toJson returns correct map', () {
      final json = user.toJson();
      expect(json, {
        'userId': 'u123',
        'email': 'test@example.com',
        'password': 'secret',
        'firstName': 'John',
        'lastName': 'Doe',
        'region': 'uk',
      });
    });

    test('fromJson creates correct object', () {
      final json = {
        'userId': 'u123',
        'email': 'test@example.com',
        'password': 'secret',
        'firstName': 'John',
        'lastName': 'Doe',
      };
      final fromJsonUser = UserEntityShort.fromJson(json);
      expect(fromJsonUser.userId, 'u123');
      expect(fromJsonUser.email, 'test@example.com');
      expect(fromJsonUser.password, 'secret');
      expect(fromJsonUser.firstName, 'John');
      expect(fromJsonUser.lastName, 'Doe');
    });

    test('fromJson(toJson(user)) returns equivalent object', () {
      final json = user.toJson();
      final fromJsonUser = UserEntityShort.fromJson(json);
      expect(fromJsonUser.userId, user.userId);
      expect(fromJsonUser.email, user.email);
      expect(fromJsonUser.password, user.password);
      expect(fromJsonUser.firstName, user.firstName);
      expect(fromJsonUser.lastName, user.lastName);
    });

    test('throws if fromJson is missing required fields', () {
      final incompleteJson = {
        'userId': 'u123',
        'email': 'test@example.com',
        // 'password' missing
        'firstName': 'John',
        'lastName': 'Doe',
      };
      expect(() => UserEntityShort.fromJson(incompleteJson), throwsA(isA<TypeError>()));
    });

    test('throws if fromJson fields are wrong type', () {
      final wrongTypeJson = {
        'userId': 123, // should be String
        'email': 'test@example.com',
        'password': 'secret',
        'firstName': 'John',
        'lastName': 'Doe',
      };
      expect(() => UserEntityShort.fromJson(wrongTypeJson), throwsA(isA<TypeError>()));
    });
  });
}
