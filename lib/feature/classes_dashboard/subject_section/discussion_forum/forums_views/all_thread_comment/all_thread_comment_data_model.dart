

class AllThreadCommentDataModel {
  int? threadId;
  String? title;
  String? body;
  List<Comments>? comments;

  AllThreadCommentDataModel({this.threadId, this.title, this.body, this.comments});

  AllThreadCommentDataModel.fromJson(Map<String, dynamic> json) {
    threadId = json['threadId'];
    title = json['title'];
    body = json['body'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['threadId'] = threadId;
    data['title'] = title;
    data['body'] = body;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  int? commentId;
  int? threadId;
  String? commentTxt;
  int? commentLikeCount;
  String? commentCreatedDate;
  int? userId;
  String? userName;
  int? replyCount;
  int? userLikeStatus;
  String? timeSinceComment;
  int? isUserDelete;
  List<Reply>? reply;

  Comments(
      {this.commentId,
        this.threadId,
        this.commentTxt,
        this.commentLikeCount,
        this.commentCreatedDate,
        this.userId,
        this.userName,
        this.replyCount,
        this.userLikeStatus,
        this.timeSinceComment,
        this.isUserDelete,
        this.reply});

  Comments.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    threadId = json['threadId'];
    commentTxt = json['commentTxt'];
    commentLikeCount = json['commentLikeCount'];
    commentCreatedDate = json['commentCreatedDate'];
    userId = json['userId'];
    userName = json['userName'];
    replyCount = json['replyCount'];
    userLikeStatus = json['userLikeStatus'];
    timeSinceComment = json['timeSinceComment'];
    isUserDelete = json['isUserDelete'];
    if (json['reply'] != null) {
      reply = <Reply>[];
      json['reply'].forEach((v) {
        reply!.add(Reply.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commentId'] = commentId;
    data['threadId'] = threadId;
    data['commentTxt'] = commentTxt;
    data['commentLikeCount'] = commentLikeCount;
    data['commentCreatedDate'] = commentCreatedDate;
    data['userId'] = userId;
    data['userName'] = userName;
    data['replyCount'] = replyCount;
    data['userLikeStatus'] = userLikeStatus;
    data['timeSinceComment'] = timeSinceComment;
    data['isUserDelete'] = isUserDelete;
    if (reply != null) {
      data['reply'] = reply!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reply {
  int? replyId;
  String? replyTxt;
  int? replyLikeCount;
  int? userLikeStatus;
  int? userId;
  String? userName;
  String? timeSinceCommentReply;
  int? isUserDelete;

  Reply(
      {this.replyId,
        this.replyTxt,
        this.replyLikeCount,
        this.userLikeStatus,
        this.userId,
        this.userName,
        this.timeSinceCommentReply,
        this.isUserDelete});

  Reply.fromJson(Map<String, dynamic> json) {
    replyId = json['replyId'];
    replyTxt = json['replyTxt'];
    replyLikeCount = json['replyLikeCount'];
    userLikeStatus = json['userLikeStatus'];
    userId = json['userId'];
    userName = json['userName'];
    timeSinceCommentReply = json['timeSinceCommentReply'];
    isUserDelete = json['isUserDelete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['replyId'] = replyId;
    data['replyTxt'] = replyTxt;
    data['replyLikeCount'] = replyLikeCount;
    data['userLikeStatus'] = userLikeStatus;
    data['userId'] = userId;
    data['userName'] = userName;
    data['timeSinceCommentReply'] = timeSinceCommentReply;
    data['isUserDelete'] = isUserDelete;
    return data;
  }
}
