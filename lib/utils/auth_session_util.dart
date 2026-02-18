import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_futter_project/domain/entities/session_entity.dart';

class AuthSessionUtil {
  static Future<SessionEntity?> getUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId != null) {
      return SessionEntity(userId);
    }
    return null;
  }

  static Future<void> saveUserSession(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  static Future<void> clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
  }
}
