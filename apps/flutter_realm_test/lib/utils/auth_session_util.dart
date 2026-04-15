import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/domain/entities/session_entity.dart';

class AuthSessionUtil {
  static const userSessionKey = 'userId';

  //todo: use abstract storage operations here
  static Future<SessionEntity?> getUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(userSessionKey);

    if (userId != null) {
      final sessionId = generateSessionId();

      return SessionEntity(userId: userId, sessionId: sessionId);
    }
    return null;
  }

  static Future<void> saveUserSession(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userSessionKey, userId);
  }

  static Future<void> clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userSessionKey);
  }

  static String generateSessionId([int length = 32]) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }
}
