class SessionEntity {
  final String userId;
  final String sessionId;

  const SessionEntity({required this.sessionId, required this.userId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionEntity &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          sessionId == other.sessionId;

  @override
  int get hashCode => userId.hashCode ^ sessionId.hashCode;
}
