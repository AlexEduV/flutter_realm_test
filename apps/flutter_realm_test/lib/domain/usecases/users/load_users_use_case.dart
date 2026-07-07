import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/repositories/user_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class LoadUsersUseCase implements UseCaseNoParams<Future<List<UserEntity>>> {
  LoadUsersUseCase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<List<UserEntity>> call() {
    return _userRepository.loadMockUsers();
  }
}
