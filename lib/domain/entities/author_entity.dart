class AuthorEntity {
  final String id;
  final String fullName;
  final String? imageSrc;

  const AuthorEntity({required this.id, required this.fullName, this.imageSrc});

  static AuthorEntity fromJson(Map<String, dynamic> json) {
    return AuthorEntity(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      imageSrc: json['image_src'] as String?,
    );
  }
}
