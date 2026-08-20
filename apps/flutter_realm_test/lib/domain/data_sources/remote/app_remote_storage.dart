abstract interface class AppRemoteStorage {
  String? getString(String key);
  Future<bool> setString(String key, String value);
  Future<bool> remove(String key);
}
