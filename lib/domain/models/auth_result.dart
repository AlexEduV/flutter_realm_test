class AuthResult {
  final bool success;
  final String? message;

  AuthResult({required this.success, this.message});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthResult &&
          runtimeType == other.runtimeType &&
          success == other.success &&
          message == other.message;

  @override
  int get hashCode => success.hashCode ^ (message?.hashCode ?? 0);
}
