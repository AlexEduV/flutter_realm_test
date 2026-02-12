import 'package:test_futter_project/domain/data_sources/auth_service.dart';
import 'package:test_futter_project/domain/repositories/base_local_storage.dart';

class MockAuthService implements AuthService {
  final BaseLocalStorage _localStorage;

  MockAuthService(this._localStorage);

  @override
  Future<bool> authenticateUser(String login, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    return true;
  }

  @override
  void changePassword(String oldPassword, String newPassword) {
    // TODO: implement changePassword
  }

  @override
  void logOut() {
    // TODO: implement logOut
  }
}
