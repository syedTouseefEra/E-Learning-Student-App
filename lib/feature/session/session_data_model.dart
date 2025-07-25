
class SessionDataModel {
  int? sessionId;
  String? sessionName;
  String? startDate;
  String? endDate;
  int? sessionStatus;

  SessionDataModel(
      {this.sessionId,
        this.sessionName,
        this.startDate,
        this.endDate,
        this.sessionStatus});

  SessionDataModel.fromJson(Map<String, dynamic> json) {
    sessionId = json['sessionId'];
    sessionName = json['sessionName'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    sessionStatus = json['sessionStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sessionId'] = sessionId;
    data['sessionName'] = sessionName;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['sessionStatus'] = sessionStatus;
    return data;
  }
}
