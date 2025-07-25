


class AssignmentParams {
  final String courseId;
  final String moduleId;
  final String topicId;
  final String batchId;
  final bool isMcq;

  AssignmentParams({
    required this.courseId,
    required this.moduleId,
    required this.topicId,
    required this.batchId,
    required this.isMcq,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AssignmentParams &&
              courseId == other.courseId &&
              moduleId == other.moduleId &&
              topicId == other.topicId &&
              batchId == other.batchId &&
              isMcq == other.isMcq;

  @override
  int get hashCode =>
      courseId.hashCode ^
      moduleId.hashCode ^
      topicId.hashCode ^
      batchId.hashCode ^
      isMcq.hashCode;
}


class SubmitAssignmentParams {
  final int scheduleId;
  final List<Map<String, dynamic>> questionList;

  SubmitAssignmentParams({
    required this.scheduleId,
    required this.questionList,
  });

  Map<String, dynamic> toJson() => {
    'scheduleId': scheduleId,
    'questionList': questionList,
  };
}


