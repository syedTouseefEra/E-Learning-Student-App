

class AttendanceReportParams {
  final String startDate;
  final String endDate;
  final String courseId;
  final String instituteId;
  final String batchId;

  AttendanceReportParams({
    required this.startDate,
    required this.endDate,
    required this.courseId,
    required this.instituteId,
    required this.batchId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AttendanceReportParams &&
              startDate == other.startDate &&
              endDate == other.endDate &&
              courseId == other.courseId &&
              instituteId == other.instituteId &&
              batchId == other.batchId;

  @override
  int get hashCode =>
      startDate.hashCode ^
      endDate.hashCode ^
      courseId.hashCode ^
      instituteId.hashCode ^
      batchId.hashCode;
}


class AssignmentReportParams {
  final String courseId;
  final String instituteId;
  final String batchId;

  AssignmentReportParams({
    required this.courseId,
    required this.instituteId,
    required this.batchId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AssignmentReportParams &&
              courseId == other.courseId &&
              instituteId == other.instituteId &&
              batchId == other.batchId;

  @override
  int get hashCode =>
      courseId.hashCode ^
      instituteId.hashCode ^
      batchId.hashCode;
}
