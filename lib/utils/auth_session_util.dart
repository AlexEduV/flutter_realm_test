import 'package:shared_preferences/shared_preferences.dart';

class AuthSessionUtil {
  static Future<Map<String, String>?> getUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final email = prefs.getString('email');
    if (userId != null && email != null) {
      return {'userId': userId, 'email': email};
    }
    return null;
  }

  static Future<void> saveUserSession(String userId, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    await prefs.setString('email', email);
  }

  static Future<void> clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('email');
  }
}
