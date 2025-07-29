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
