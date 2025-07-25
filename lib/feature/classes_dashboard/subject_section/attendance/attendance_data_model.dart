class AttendanceDataModel {
  int? studentId;
  String? studentName;
  String? statusMessage;
  String? attendanceDate;
  Null? image;
  int? courseId;
  String? courseName;
  int? isPresent;

  AttendanceDataModel(
      {this.studentId,
        this.studentName,
        this.statusMessage,
        this.attendanceDate,
        this.image,
        this.courseId,
        this.courseName,
        this.isPresent});

  AttendanceDataModel.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    studentName = json['studentName'];
    statusMessage = json['statusMessage'];
    attendanceDate = json['attendanceDate'];
    image = json['image'];
    courseId = json['courseId'];
    courseName = json['courseName'];
    isPresent = json['isPresent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentId'] = studentId;
    data['studentName'] = studentName;
    data['statusMessage'] = statusMessage;
    data['attendanceDate'] = attendanceDate;
    data['image'] = image;
    data['courseId'] = courseId;
    data['courseName'] = courseName;
    data['isPresent'] = isPresent;
    return data;
  }
}
