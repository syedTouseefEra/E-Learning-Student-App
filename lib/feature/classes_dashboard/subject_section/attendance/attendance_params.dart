

class AttendanceParams {
  final String startDate;
  final String endDate;
  final String courseId;
  final String studentId;
  final String batchId;

  AttendanceParams({
    required this.startDate,
    required this.endDate,
    required this.courseId,
    required this.studentId,
    required this.batchId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AttendanceParams &&
              startDate == other.startDate &&
              endDate == other.endDate &&
              courseId == other.courseId &&
              studentId == other.studentId &&
              batchId == other.batchId;

  @override
  int get hashCode =>
      startDate.hashCode ^
      endDate.hashCode ^
      courseId.hashCode ^
      studentId.hashCode ^
      batchId.hashCode;
}
