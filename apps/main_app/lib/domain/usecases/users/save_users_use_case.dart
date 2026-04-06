import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/repositories/user_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class SaveUsersUseCase implements UseCaseWithParams<List<UserEntity>, Future<void>> {
  final UserRepository _userRepository;

  SaveUsersUseCase(this._userRepository);

  @override
  Future<void> call(List<UserEntity> params) {
    return _userRepository.saveMockUsers(params);
  }
}
