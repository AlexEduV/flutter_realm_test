class SessionEntity {
  const SessionEntity({required this.sessionId, required this.userId});

  final String userId;
  final String sessionId;

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
