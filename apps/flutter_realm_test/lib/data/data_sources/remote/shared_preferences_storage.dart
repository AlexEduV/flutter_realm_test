import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/domain/data_sources/remote/base_remote_storage.dart';

class SharedPreferencesStorage implements BaseRemoteStorage {
  SharedPreferencesStorage(this._prefs);

  final SharedPreferences _prefs;

  @override
  String? getString(String key) => _prefs.getString(key);

  @override
  Future<bool> remove(String key) => _prefs.remove(key);

  @override
  Future<bool> setString(String key, String value) => _prefs.setString(key, value);
}
