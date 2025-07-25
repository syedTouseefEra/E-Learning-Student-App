

class AttendanceReportDataModel {
  int? studentId;
  int? courseId;
  String? courseName;
  String? image;
  String? registrationNumber;
  String? studentName;
  List<AttandenceReport>? attandenceReport;

  AttendanceReportDataModel(
      {this.studentId,
        this.courseId,
        this.courseName,
        this.image,
        this.registrationNumber,
        this.studentName,
        this.attandenceReport});

  AttendanceReportDataModel.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    courseId = json['courseId'];
    courseName = json['courseName'];
    image = json['image'];
    registrationNumber = json['registrationNumber'];
    studentName = json['studentName'];
    if (json['attandenceReport'] != null) {
      attandenceReport = <AttandenceReport>[];
      json['attandenceReport'].forEach((v) {
        attandenceReport!.add(AttandenceReport.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentId'] = studentId;
    data['courseId'] = courseId;
    data['courseName'] = courseName;
    data['image'] = image;
    data['registrationNumber'] = registrationNumber;
    data['studentName'] = studentName;
    if (attandenceReport != null) {
      data['attandenceReport'] =
          attandenceReport!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttandenceReport {
  String? calanderDate;
  int? courseId;
  String? courseName;
  String? statusMessage;
  int? isPresent;

  AttandenceReport(
      {this.calanderDate,
        this.courseId,
        this.courseName,
        this.statusMessage,
        this.isPresent});

  AttandenceReport.fromJson(Map<String, dynamic> json) {
    calanderDate = json['calanderDate'];
    courseId = json['courseId'];
    courseName = json['courseName'];
    statusMessage = json['statusMessage'];
    isPresent = json['isPresent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['calanderDate'] = calanderDate;
    data['courseId'] = courseId;
    data['courseName'] = courseName;
    data['statusMessage'] = statusMessage;
    data['isPresent'] = isPresent;
    return data;
  }
}


class AssignmentReportDataModel {
  int? studentId;
  String? firstName;
  String? middlemiddleName;
  String? lastName;
  String? registrationNumber;
  int? courseId;
  String? courseName;
  int? batchId;
  List<AssignScheduleList>? assignScheduleList;

  AssignmentReportDataModel(
      {this.studentId,
        this.firstName,
        this.middlemiddleName,
        this.lastName,
        this.registrationNumber,
        this.courseId,
        this.courseName,
        this.batchId,
        this.assignScheduleList});

  AssignmentReportDataModel.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    firstName = json['firstName'];
    middlemiddleName = json['middlemiddleName'];
    lastName = json['lastName'];
    registrationNumber = json['registrationNumber'];
    courseId = json['courseId'];
    courseName = json['courseName'];
    batchId = json['batchId'];
    if (json['assignScheduleList'] != null) {
      assignScheduleList = <AssignScheduleList>[];
      json['assignScheduleList'].forEach((v) {
        assignScheduleList!.add(AssignScheduleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentId'] = studentId;
    data['firstName'] = firstName;
    data['middlemiddleName'] = middlemiddleName;
    data['lastName'] = lastName;
    data['registrationNumber'] = registrationNumber;
    data['courseId'] = courseId;
    data['courseName'] = courseName;
    data['batchId'] = batchId;
    if (assignScheduleList != null) {
      data['assignScheduleList'] =
          assignScheduleList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssignScheduleList {
  int? courseId;
  String? courseName;
  int? moduleId;
  String? moduleName;
  int? topicId;
  String? topicName;
  int? scheduleId;
  int? assignmentType;
  List<AssignMarksReportList>? assignMarksReportList;

  AssignScheduleList(
      {this.courseId,
        this.courseName,
        this.moduleId,
        this.moduleName,
        this.topicId,
        this.topicName,
        this.scheduleId,
        this.assignmentType,
        this.assignMarksReportList});

  AssignScheduleList.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    courseName = json['courseName'];
    moduleId = json['moduleId'];
    moduleName = json['moduleName'];
    topicId = json['topicId'];
    topicName = json['topicName'];
    scheduleId = json['scheduleId'];
    assignmentType = json['assignmentType'];
    if (json['assignMarksReportList'] != null) {
      assignMarksReportList = <AssignMarksReportList>[];
      json['assignMarksReportList'].forEach((v) {
        assignMarksReportList!.add(AssignMarksReportList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['courseId'] = courseId;
    data['courseName'] = courseName;
    data['moduleId'] = moduleId;
    data['moduleName'] = moduleName;
    data['topicId'] = topicId;
    data['topicName'] = topicName;
    data['scheduleId'] = scheduleId;
    data['assignmentType'] = assignmentType;
    if (assignMarksReportList != null) {
      data['assignMarksReportList'] =
          assignMarksReportList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssignMarksReportList {
  int? scheduleId;
  int? assignmentType;
  int? studentId;
  double? totalMarks;
  int? isAttempt;
  double? userMarks;
  double? percentage;

  AssignMarksReportList(
      {this.scheduleId,
        this.assignmentType,
        this.studentId,
        this.totalMarks,
        this.isAttempt,
        this.userMarks,
        this.percentage});

  AssignMarksReportList.fromJson(Map<String, dynamic> json) {
    scheduleId = json['scheduleId'];
    assignmentType = json['assignmentType'];
    studentId = json['studentId'];
    totalMarks = json['totalMarks'];
    isAttempt = json['isAttempt'];
    userMarks = json['userMarks'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scheduleId'] = scheduleId;
    data['assignmentType'] = assignmentType;
    data['studentId'] = studentId;
    data['totalMarks'] = totalMarks;
    data['isAttempt'] = isAttempt;
    data['userMarks'] = userMarks;
    data['percentage'] = percentage;
    return data;
  }
}
