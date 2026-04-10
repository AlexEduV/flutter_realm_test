abstract class EnvLocalDataSource {
  Future<void> init();

  String get({required String key, String fallback});
}
