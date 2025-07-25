


class CreateForumParams {
  final String forumId;

  CreateForumParams({
    required this.forumId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CreateForumParams &&
              forumId == other.forumId;

  @override
  int get hashCode =>
      forumId.hashCode;
}



