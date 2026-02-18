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

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'email': email,
    'password': password,
    'fullName': fullName,
  };

  factory UserEntityShort.fromJson(Map<String, dynamic> json) {
    return UserEntityShort(
      userId: json['userId'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      fullName: json['fullName'] as String,
    );
  }
}
