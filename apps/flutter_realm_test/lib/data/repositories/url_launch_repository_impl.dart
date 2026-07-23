import 'package:test_flutter_project/domain/services/external_link_service.dart';
import 'package:test_flutter_project/domain/repositories/url_launch_repository.dart';

class UrlLaunchRepositoryImpl implements UrlLaunchRepository {
  UrlLaunchRepositoryImpl(this._externalLinkService);

  final ExternalLinkService _externalLinkService;

  @override
  Future<void> openUrl(String link) {
    return _externalLinkService.openUrl(link);
  }
}
