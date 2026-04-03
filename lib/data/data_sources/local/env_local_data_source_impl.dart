import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_futter_project/domain/data_sources/local/env_local_data_source.dart';

import '../../../common/constants/app_asset_routes.dart';

class EnvLocalDataSourceImpl implements EnvLocalDataSource {
  final _dotEnv = dotenv;

  @override
  Future<void> init() async {
    await _dotEnv.load(fileName: AppAssetRoutes.envRoute);
  }

  @override
  String get({required String key, String fallback = ''}) {
    return _dotEnv.get(key, fallback: fallback);
  }
}
