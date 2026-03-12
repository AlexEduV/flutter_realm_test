import 'package:test_futter_project/domain/models/share_params_model.dart';
import 'package:test_futter_project/domain/repositories/share_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class ShareUseCase extends UseCaseWithParams<ShareParamsModel, Future<void>> {
  final ShareRepository shareRepository;

  ShareUseCase(this.shareRepository);

  @override
  Future<void> call(ShareParamsModel model) {
    return shareRepository.share(model);
  }
}
