class UserEntityShort {
  final String userId;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String region;

  const UserEntityShort({
    required this.userId,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.region,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'email': email,
    'password': password,
    'firstName': firstName,
    'lastName': lastName,
    'region': region,
  };

  factory UserEntityShort.fromJson(Map<String, dynamic> json) {
    return UserEntityShort(
      userId: json['userId'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      region: json['region'] as String,
    );
  }
}
