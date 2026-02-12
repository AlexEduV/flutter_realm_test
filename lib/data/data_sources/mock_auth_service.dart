import 'package:test_futter_project/domain/data_sources/auth_service.dart';
import 'package:test_futter_project/domain/data_sources/base_local_storage.dart';
import 'package:test_futter_project/domain/models/auth_result.dart';
import 'package:test_futter_project/domain/repositories/auth_repository.dart';

class MockAuthService implements AuthService {
  final BaseLocalStorage _localStorage;
  final AuthRepository _authRepository;

  MockAuthService(this._localStorage, this._authRepository);

  @override
  Future<AuthResult> login(String email, String password) async {
    return _authRepository.login(email, password);
  }

  @override
  void changePassword(String oldPassword, String newPassword) {
    // TODO: implement changePassword
  }

  @override
  void logOut() {
    _authRepository.logOut();
  }

  @override
  Future<AuthResult> register(String email, String password) {
    return _authRepository.register(email, password);
  }
}
