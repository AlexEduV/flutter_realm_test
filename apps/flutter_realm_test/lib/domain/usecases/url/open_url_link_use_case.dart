import 'package:test_futter_project/domain/repositories/url_launch_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class OpenUrlLinkUseCase extends UseCaseWithParams<String, Future<void>> {
  final UrlLaunchRepository _urlLaunchRepository;

  OpenUrlLinkUseCase(this._urlLaunchRepository);

  @override
  Future<void> call(String link) {
    return _urlLaunchRepository.openUrl(link);
  }
}
