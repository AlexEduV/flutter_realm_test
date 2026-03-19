import 'package:test_futter_project/domain/repositories/user_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class GetMaxUserIdUseCase implements UseCaseNoParams<int> {
  final UserRepository _userRepository;

  GetMaxUserIdUseCase(this._userRepository);

  @override
  int call() {
    return _userRepository.getMaxUserId();
  }
}
