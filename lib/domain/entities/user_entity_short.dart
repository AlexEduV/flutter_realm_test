class UserEntityShort {
  final String userId;
  final String email;
  final String password;
  final String fullName;

  const UserEntityShort({
    required this.userId,
    required this.email,
    required this.password,
    required this.fullName,
  });

  UserEntityShort copyWith({String? userId, String? email, String? password, String? fullName}) {
    return UserEntityShort(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
    );
  }
}
