class DashboardDataModel {
  int? userId;
  String? userName;
  String? name;
  String? mobileNo;
  String? email;
  double? latitude;
  double? longitude;
  int? userRoleId;
  String? roleName;
  bool? isMobileVerify;
  bool? isEmailVerify;
  int? organizationId;
  int? instituteId;
  String? instituteName;
  bool? isApproved;
  bool? isBlock;
  String? token;

  DashboardDataModel(
      {this.userId,
        this.userName,
        this.name,
        this.mobileNo,
        this.email,
        this.latitude,
        this.longitude,
        this.userRoleId,
        this.roleName,
        this.isMobileVerify,
        this.isEmailVerify,
        this.organizationId,
        this.instituteId,
        this.instituteName,
        this.isApproved,
        this.isBlock,
        this.token});

  DashboardDataModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    name = json['name'];
    mobileNo = json['mobileNo'];
    email = json['email'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    userRoleId = json['userRoleId'];
    roleName = json['roleName'];
    isMobileVerify = json['isMobileVerify'];
    isEmailVerify = json['isEmailVerify'];
    organizationId = json['organizationId'];
    instituteId = json['instituteId'];
    instituteName = json['instituteName'];
    isApproved = json['isApproved'];
    isBlock = json['isBlock'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['name'] = name;
    data['mobileNo'] = mobileNo;
    data['email'] = email;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['userRoleId'] = userRoleId;
    data['roleName'] = roleName;
    data['isMobileVerify'] = isMobileVerify;
    data['isEmailVerify'] = isEmailVerify;
    data['organizationId'] = organizationId;
    data['instituteId'] = instituteId;
    data['instituteName'] = instituteName;
    data['isApproved'] = isApproved;
    data['isBlock'] = isBlock;
    data['token'] = token;
    return data;
  }
}
