


class ForumReplyParams {
  final String forumId;

  ForumReplyParams({
    required this.forumId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ForumReplyParams &&
              forumId == other.forumId;

  @override
  int get hashCode =>
      forumId.hashCode;
}



