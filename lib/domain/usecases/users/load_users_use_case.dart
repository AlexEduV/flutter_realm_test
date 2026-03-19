import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/repositories/user_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class LoadUsersUseCase implements UseCaseNoParams<Future<List<UserEntity>>> {
  final UserRepository _userRepository;

  LoadUsersUseCase(this._userRepository);

  @override
  Future<List<UserEntity>> call() {
    return _userRepository.loadMockUsers();
  }
}
