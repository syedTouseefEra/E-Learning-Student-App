

class NoticeDataModel {
  int? noticeId;
  int? courseId;
  String? courseName;
  int? instituteId;
  String? title;
  String? description;
  String? file;
  Null? noticeType;
  String? createdDate;
  String? instituteName;

  NoticeDataModel(
      {this.noticeId,
        this.courseId,
        this.courseName,
        this.instituteId,
        this.title,
        this.description,
        this.file,
        this.noticeType,
        this.createdDate,
        this.instituteName});

  NoticeDataModel.fromJson(Map<String, dynamic> json) {
    noticeId = json['noticeId'];
    courseId = json['courseId'];
    courseName = json['courseName'];
    instituteId = json['instituteId'];
    title = json['title'];
    description = json['description'];
    file = json['file'];
    noticeType = json['noticeType'];
    createdDate = json['createdDate'];
    instituteName = json['instituteName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['noticeId'] = noticeId;
    data['courseId'] = courseId;
    data['courseName'] = courseName;
    data['instituteId'] = instituteId;
    data['title'] = title;
    data['description'] = description;
    data['file'] = file;
    data['noticeType'] = noticeType;
    data['createdDate'] = createdDate;
    data['instituteName'] = instituteName;
    return data;
  }
}
