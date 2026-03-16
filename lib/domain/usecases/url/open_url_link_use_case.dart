import 'package:test_futter_project/domain/repositories/url_launch_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class OpenUrlLinkUseCase extends UseCaseWithParams<String, Future<void>> {
  final UrlLaunchRepository urlLaunchRepository;

  OpenUrlLinkUseCase(this.urlLaunchRepository);

  @override
  Future<void> call(String link) {
    return urlLaunchRepository.openUrl(link);
  }
}
