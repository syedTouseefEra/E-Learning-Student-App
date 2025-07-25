
class ChooseAccountDataModel {
  int? organizationId;
  String? organizationName;
  int? instituteId;
  String? instituteName;
  int? userId;
  int? userRoleId;
  String? roleName;
  String? name;
  String? employeeId;
  int? studentId;

  ChooseAccountDataModel(
      {this.organizationId,
        this.organizationName,
        this.instituteId,
        this.instituteName,
        this.userId,
        this.userRoleId,
        this.roleName,
        this.name,
        this.employeeId,
        this.studentId});

  ChooseAccountDataModel.fromJson(Map<String, dynamic> json) {
    organizationId = json['organizationId'];
    organizationName = json['organizationName'];
    instituteId = json['instituteId'];
    instituteName = json['instituteName'];
    userId = json['userId'];
    userRoleId = json['userRoleId'];
    roleName = json['roleName'];
    name = json['name'];
    employeeId = json['employeeId'];
    studentId = json['studentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['organizationId'] = organizationId;
    data['organizationName'] = organizationName;
    data['instituteId'] = instituteId;
    data['instituteName'] = instituteName;
    data['userId'] = userId;
    data['userRoleId'] = userRoleId;
    data['roleName'] = roleName;
    data['name'] = name;
    data['employeeId'] = employeeId;
    data['studentId'] = studentId;
    return data;
  }
}
