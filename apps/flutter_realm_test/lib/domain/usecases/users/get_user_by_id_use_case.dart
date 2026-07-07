import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/repositories/user_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class GetUserByIdUseCase implements UseCaseWithParams<String, UserEntity?> {
  GetUserByIdUseCase(this._userRepository);

  final UserRepository _userRepository;

  @override
  UserEntity? call(String params) {
    return _userRepository.getUserById(params);
  }
}
