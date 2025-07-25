


class AssignmentByModuleParams {
  final String courseId;
  final String moduleId;
  final String batchId;

  AssignmentByModuleParams({
    required this.courseId,
    required this.moduleId,
    required this.batchId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AssignmentByModuleParams &&
              courseId == other.courseId &&
              moduleId == other.moduleId &&
              batchId == other.batchId;

  @override
  int get hashCode =>
      courseId.hashCode ^
      moduleId.hashCode ^
      batchId.hashCode;
}



