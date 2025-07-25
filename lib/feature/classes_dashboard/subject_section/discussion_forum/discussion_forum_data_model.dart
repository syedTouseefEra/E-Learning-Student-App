

class DiscussionForumDataModel {
  int? id;
  int? courseId;
  String? courseName;
  int? batchId;
  String? title;
  String? body;
  String? createdDate;
  int? threadCount;
  String? timeSinceLastThread;

  DiscussionForumDataModel(
      {this.id,
        this.courseId,
        this.courseName,
        this.batchId,
        this.title,
        this.body,
        this.createdDate,
        this.threadCount,
        this.timeSinceLastThread});

  DiscussionForumDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['courseId'];
    courseName = json['courseName'];
    batchId = json['batchId'];
    title = json['title'];
    body = json['body'];
    createdDate = json['createdDate'];
    threadCount = json['threadCount'];
    timeSinceLastThread = json['timeSinceLastThread'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['courseId'] = courseId;
    data['courseName'] = courseName;
    data['batchId'] = batchId;
    data['title'] = title;
    data['body'] = body;
    data['createdDate'] = createdDate;
    data['threadCount'] = threadCount;
    data['timeSinceLastThread'] = timeSinceLastThread;
    return data;
  }
}
