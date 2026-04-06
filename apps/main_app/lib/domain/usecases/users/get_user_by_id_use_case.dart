import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/repositories/user_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class GetUserByIdUseCase implements UseCaseWithParams<String, UserEntity?> {
  final UserRepository _userRepository;

  GetUserByIdUseCase(this._userRepository);

  @override
  UserEntity? call(String params) {
    return _userRepository.getUserById(params);
  }
}
