


class AllThreadCommentParams {
  final String threadId;

  AllThreadCommentParams({
    required this.threadId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AllThreadCommentParams &&
              threadId == other.threadId;

  @override
  int get hashCode =>
      threadId.hashCode;
}



