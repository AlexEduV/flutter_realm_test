import 'package:test_flutter_project/domain/repositories/user_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class GetMaxUserIdUseCase implements UseCaseNoParams<int> {
  GetMaxUserIdUseCase(this._userRepository);

  final UserRepository _userRepository;

  @override
  int call() {
    return _userRepository.getMaxUserId();
  }
}
