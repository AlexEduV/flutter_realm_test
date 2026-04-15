import 'package:test_flutter_project/domain/data_sources/local/env_local_data_source.dart';
import 'package:test_flutter_project/domain/repositories/env_repository.dart';

class EnvRepositoryImpl implements EnvRepository {
  final EnvLocalDataSource envLocalDataSource;

  EnvRepositoryImpl(this.envLocalDataSource);

  @override
  Future<void> init() {
    return envLocalDataSource.init();
  }

  @override
  String get({required String key, String fallback = ''}) {
    return envLocalDataSource.get(key: key, fallback: fallback);
  }
}
