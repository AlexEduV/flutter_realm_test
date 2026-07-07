class LoginModel {
  LoginModel(this.email, this.password);

  final String email;
  final String password;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginModel &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password;

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
