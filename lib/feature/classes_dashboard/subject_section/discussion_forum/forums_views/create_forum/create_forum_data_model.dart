
class CreateForumDataModel {
  int? id;
  String? threadTitle;
  String? threadBody;
  int? forumId;
  String? forumTitle;
  String? forumBody;
  int? likeCount;
  String? createdDate;
  int? commentCount;
  String? lastRepliedUser;
  int? lastRepliedUserId;
  int? userLikeStatus;
  String? timeSinceLastReply;

  CreateForumDataModel(
      {this.id,
        this.threadTitle,
        this.threadBody,
        this.forumId,
        this.forumTitle,
        this.forumBody,
        this.likeCount,
        this.createdDate,
        this.commentCount,
        this.lastRepliedUser,
        this.lastRepliedUserId,
        this.userLikeStatus,
        this.timeSinceLastReply});

  CreateForumDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    threadTitle = json['ThreadTitle'];
    threadBody = json['ThreadBody'];
    forumId = json['forumId'];
    forumTitle = json['forumTitle'];
    forumBody = json['forumBody'];
    likeCount = json['likeCount'];
    createdDate = json['createdDate'];
    commentCount = json['commentCount'];
    lastRepliedUser = json['lastRepliedUser'];
    lastRepliedUserId = json['lastRepliedUserId'];
    userLikeStatus = json['userLikeStatus'];
    timeSinceLastReply = json['timeSinceLastReply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ThreadTitle'] = threadTitle;
    data['ThreadBody'] = threadBody;
    data['forumId'] = forumId;
    data['forumTitle'] = forumTitle;
    data['forumBody'] = forumBody;
    data['likeCount'] = likeCount;
    data['createdDate'] = createdDate;
    data['commentCount'] = commentCount;
    data['lastRepliedUser'] = lastRepliedUser;
    data['lastRepliedUserId'] = lastRepliedUserId;
    data['userLikeStatus'] = userLikeStatus;
    data['timeSinceLastReply'] = timeSinceLastReply;
    return data;
  }
}
