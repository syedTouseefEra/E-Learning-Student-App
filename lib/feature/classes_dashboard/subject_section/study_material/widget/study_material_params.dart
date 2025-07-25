

class StudyMaterialParams {
  final String topicId;

  StudyMaterialParams({required this.topicId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is StudyMaterialParams && topicId == other.topicId;

  @override
  int get hashCode => topicId.hashCode;
}
