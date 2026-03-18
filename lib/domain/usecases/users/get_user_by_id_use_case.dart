import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';
import 'package:test_futter_project/mocks/mock_users.dart';

class GetUserByIdUseCase implements UseCaseWithParams<String, UserEntity?> {
  @override
  UserEntity? call(String params) {
    return MockUsers.getUserById(params);
  }
}
