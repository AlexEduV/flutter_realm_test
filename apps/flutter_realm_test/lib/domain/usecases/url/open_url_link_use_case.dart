import 'package:test_flutter_project/domain/repositories/url_launch_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class OpenUrlLinkUseCase extends UseCaseWithParams<String, Future<void>> {
  OpenUrlLinkUseCase(this._urlLaunchRepository);

  final UrlLaunchRepository _urlLaunchRepository;

  @override
  Future<void> call(String link) {
    return _urlLaunchRepository.openUrl(link);
  }
}
