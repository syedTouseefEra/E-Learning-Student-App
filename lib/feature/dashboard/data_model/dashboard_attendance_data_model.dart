class DashboardAttendanceDataModel {
  String? subjectName;
  int? subjectId;
  int? presentDays;
  int? absentDays;
  int? totalClasses;
  int? presentPercentage;
  int? absentPercentage;

  DashboardAttendanceDataModel(
      {this.subjectName,
        this.subjectId,
        this.presentDays,
        this.absentDays,
        this.totalClasses,
        this.presentPercentage,
        this.absentPercentage});

  DashboardAttendanceDataModel.fromJson(Map<String, dynamic> json) {
    subjectName = json['subjectName'];
    subjectId = json['subjectId'];
    presentDays = json['presentDays'];
    absentDays = json['absentDays'];
    totalClasses = json['TotalClasses'];
    presentPercentage = json['PresentPercentage'];
    absentPercentage = json['AbsentPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subjectName'] = this.subjectName;
    data['subjectId'] = this.subjectId;
    data['presentDays'] = this.presentDays;
    data['absentDays'] = this.absentDays;
    data['TotalClasses'] = this.totalClasses;
    data['PresentPercentage'] = this.presentPercentage;
    data['AbsentPercentage'] = this.absentPercentage;
    return data;
  }
}


class DashboardAssignmentDataModel {
  int? userId;
  int? questionCount;
  int? courseId;
  String? courseName;
  int? batchId;
  int? moduleId;
  int? topicId;
  int? assignmentType;
  String? startDateTime;

  DashboardAssignmentDataModel(
      {this.userId,
        this.questionCount,
        this.courseId,
        this.courseName,
        this.batchId,
        this.moduleId,
        this.topicId,
        this.assignmentType,
        this.startDateTime});

  DashboardAssignmentDataModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    questionCount = json['questionCount'];
    courseId = json['courseId'];
    courseName = json['courseName'];
    batchId = json['batchId'];
    moduleId = json['moduleId'];
    topicId = json['topicId'];
    assignmentType = json['assignmentType'];
    startDateTime = json['startDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['questionCount'] = this.questionCount;
    data['courseId'] = this.courseId;
    data['courseName'] = this.courseName;
    data['batchId'] = this.batchId;
    data['moduleId'] = this.moduleId;
    data['topicId'] = this.topicId;
    data['assignmentType'] = this.assignmentType;
    data['startDateTime'] = this.startDateTime;
    return data;
  }
}
