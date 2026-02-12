abstract class AuthService {
  Future<bool> authenticateUser(String login, String password);

  void changePassword(String oldPassword, String newPassword);

  void logOut();
}
