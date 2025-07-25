


class DiscussionForumParams {
  final String courseId;
  final String batchId;

  DiscussionForumParams({
    required this.courseId,
    required this.batchId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DiscussionForumParams &&
              courseId == other.courseId &&
              batchId == other.batchId;

  @override
  int get hashCode =>
      courseId.hashCode ^
      batchId.hashCode;
}



