

class StudentLoginDataModal {
  int? userId;
  String? userName;
  String? name;
  double? latitude;
  int? profileCount;
  double? longitude;
  bool? isMobileVerify;
  bool? isEmailVerify;
  String? token;

  StudentLoginDataModal({
    this.userId,
    this.userName,
    this.name,
    this.latitude,
    this.profileCount,
    this.longitude,
    this.isMobileVerify,
    this.isEmailVerify,
    this.token,
  });

  StudentLoginDataModal.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    name = json['name'];
    latitude = json['latitude'];
    profileCount = json['profileCount'];
    longitude = json['longitude'];
    isMobileVerify = json['isMobileVerify'];
    isEmailVerify = json['isEmailVerify'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['name'] = name;
    data['latitude'] = latitude;
    data['profileCount'] = profileCount;
    data['longitude'] = longitude;
    data['isMobileVerify'] = isMobileVerify;
    data['isEmailVerify'] = isEmailVerify;
    data['token'] = token;
    return data;
  }


}
