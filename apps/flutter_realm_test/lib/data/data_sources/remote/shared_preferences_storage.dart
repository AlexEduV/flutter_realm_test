import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/domain/data_sources/remote/app_remote_storage.dart';

class SharedPreferencesStorage implements AppRemoteStorage {
  SharedPreferencesStorage(this._prefs);

  final SharedPreferencesAsync _prefs;

  @override
  Future<String?> getString(String key) => _prefs.getString(key);

  @override
  Future<void> remove(String key) => _prefs.remove(key);

  @override
  Future<void> setString(String key, String value) => _prefs.setString(key, value);
}
