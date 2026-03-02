class AuthorEntity {
  final String id;
  final String fullName;

  const AuthorEntity({required this.id, required this.fullName});

  static AuthorEntity fromJson(Map<String, dynamic> json) {
    return AuthorEntity(id: json['id'] as String, fullName: json['full_name'] as String);
  }
}
