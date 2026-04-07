abstract class EnvRepository {
  Future<void> init();

  String get({required String key, String fallback});
}
