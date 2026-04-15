import 'package:test_flutter_project/domain/data_sources/remote/auth_remote_data_source.dart';
import 'package:test_flutter_project/domain/models/auth_result.dart';
import 'package:test_flutter_project/domain/repositories/auth_repository.dart';

class MockAuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthRepository _authRepository;

  MockAuthRemoteDataSourceImpl(this._authRepository);

  @override
  Future<AuthResult> login(String email, String password) {
    return _authRepository.login(email: email, password: password);
  }

  @override
  void changePassword(String oldPassword, String newPassword) {
    // TODO: implement changePassword
  }

  @override
  Future<void> logOut() async {
    await _authRepository.logOut();
  }

  @override
  Future<AuthResult> register(String email, String password, String firstName, String lastName) {
    return _authRepository.register(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
  }

  @override
  Future<void> deleteAccount(String email) async {
    await _authRepository.deleteAccount(email);
  }
}
