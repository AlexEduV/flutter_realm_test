import 'package:test_flutter_project/domain/models/share_params_model.dart';
import 'package:test_flutter_project/domain/repositories/share_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class ShareUseCase extends UseCaseWithParams<ShareParamsModel, Future<void>> {
  final ShareRepository _shareRepository;

  ShareUseCase(this._shareRepository);

  @override
  Future<void> call(ShareParamsModel model) {
    return _shareRepository.share(model);
  }
}
