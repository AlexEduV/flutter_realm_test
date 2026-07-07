import 'package:test_flutter_project/domain/data_sources/local/url_launch_local_data_source.dart';
import 'package:test_flutter_project/domain/repositories/url_launch_repository.dart';

class UrlLaunchRepositoryImpl implements UrlLaunchRepository {
  UrlLaunchRepositoryImpl(this._launchLocalDataSource);

  final UrlLaunchLocalDataSource _launchLocalDataSource;

  @override
  Future<void> openUrl(String link) {
    return _launchLocalDataSource.openUrl(link);
  }
}
