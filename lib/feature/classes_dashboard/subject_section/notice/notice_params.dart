


class NoticeParams {
  final String courseId;
  final String sessionId;
  final String instituteId;
  final String batchId;

  NoticeParams({
    required this.courseId,
    required this.sessionId,
    required this.instituteId,
    required this.batchId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NoticeParams &&
              courseId == other.courseId &&
              sessionId == other.sessionId &&
              instituteId == other.instituteId &&
              batchId == other.batchId;

  @override
  int get hashCode =>
      courseId.hashCode ^
      sessionId.hashCode ^
      instituteId.hashCode ^
      batchId.hashCode;
}
