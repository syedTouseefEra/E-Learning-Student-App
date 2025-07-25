
class QueryDataModel {
  int? queryId;
  String? query;
  String? fileUrl;
  int? courseId;
  String? courseName;
  int? studentId;
  String? teacherName;
  int? isView;
  int? teacherId;
  String? studentName;
  List<ReplyList>? replyList;

  QueryDataModel(
      {this.queryId,
        this.query,
        this.fileUrl,
        this.courseId,
        this.courseName,
        this.studentId,
        this.teacherName,
        this.isView,
        this.teacherId,
        this.studentName,
        this.replyList});

  QueryDataModel.fromJson(Map<String, dynamic> json) {
    queryId = json['queryId'];
    query = json['query'];
    fileUrl = json['fileUrl'];
    courseId = json['courseId'];
    courseName = json['courseName'];
    studentId = json['studentId'];
    teacherName = json['teacherName'];
    isView = json['isView'];
    teacherId = json['teacherId'];
    studentName = json['studentName'];
    if (json['replyList'] != null) {
      replyList = <ReplyList>[];
      json['replyList'].forEach((v) {
        replyList!.add(ReplyList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['queryId'] = queryId;
    data['query'] = query;
    data['fileUrl'] = fileUrl;
    data['courseId'] = courseId;
    data['courseName'] = courseName;
    data['studentId'] = studentId;
    data['teacherName'] = teacherName;
    data['isView'] = isView;
    data['teacherId'] = teacherId;
    data['studentName'] = studentName;
    if (replyList != null) {
      data['replyList'] = replyList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReplyList {
  int? replyId;
  int? queryId;
  String? reply;
  String? fileUrl;
  int? teacherId;
  String? teacherName;
  int? studentId;
  String? studentName;

  ReplyList(
      {this.replyId,
        this.queryId,
        this.reply,
        this.fileUrl,
        this.teacherId,
        this.teacherName,
        this.studentId,
        this.studentName});

  ReplyList.fromJson(Map<String, dynamic> json) {
    replyId = json['replyId'];
    queryId = json['queryId'];
    reply = json['reply'];
    fileUrl = json['fileUrl'];
    teacherId = json['teacherId'];
    teacherName = json['teacherName'];
    studentId = json['studentId'];
    studentName = json['studentName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['replyId'] = replyId;
    data['queryId'] = queryId;
    data['reply'] = reply;
    data['fileUrl'] = fileUrl;
    data['teacherId'] = teacherId;
    data['teacherName'] = teacherName;
    data['studentId'] = studentId;
    data['studentName'] = studentName;
    return data;
  }
}
