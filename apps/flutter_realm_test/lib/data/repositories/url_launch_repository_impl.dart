import 'package:test_flutter_project/domain/data_sources/local/url_launch_local_data_source.dart';
import 'package:test_flutter_project/domain/repositories/url_launch_repository.dart';

class UrlLaunchRepositoryImpl implements UrlLaunchRepository {
  final UrlLaunchLocalDataSource _launchLocalDataSource;

  UrlLaunchRepositoryImpl(this._launchLocalDataSource);

  @override
  Future<void> openUrl(String link) {
    return _launchLocalDataSource.openUrl(link);
  }
}
