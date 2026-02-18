import 'package:shared_preferences/shared_preferences.dart';

//todo: retrieval won't work if the users are not stored as well
class AuthSessionUtil {
  static Future<Map<String, String>?> getUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    final fullName = prefs.getString('fullName');
    if (userId != null && email != null && password != null && fullName != null) {
      return {'userId': userId, 'email': email, 'password': password, 'fullName': fullName};
    }
    return null;
  }

  static Future<void> saveUserSession(String userId, String email, Stir) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    await prefs.setString('email', email);
  }

  static Future<void> clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('email');
    await prefs.remove('password');
    await prefs.remove('fullName');
  }
}
