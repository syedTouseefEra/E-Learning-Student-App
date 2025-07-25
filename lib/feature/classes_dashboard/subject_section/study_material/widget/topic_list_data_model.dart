class TopicListDataModel {
  int? id;
  int? topicId;
  String? topicName;
  String? topicDescription;
  int? materialType;
  String? materialTypeName;
  String? materialTitle;
  String? description;
  String? image;
  String? createdDate;
  String? publishDateTime;
  String? publishStatus;

  // Constructor
  TopicListDataModel({
    this.id,
    this.topicId,
    this.topicName,
    this.topicDescription,
    this.materialType,
    this.materialTypeName,
    this.materialTitle,
    this.description,
    this.image,
    this.createdDate,
    this.publishDateTime,
    this.publishStatus,
  });

  // From JSON constructor
  TopicListDataModel.fromJson(Map<String, dynamic> json) {
    id = _parseInt(json['id']);
    topicId = _parseInt(json['topicId']);
    topicName = json['topicName'];
    topicDescription = json['topicDescription'];
    materialType = _parseInt(json['materialType']);
    materialTypeName = json['materialTypeName'];
    materialTitle = json['materialTitle'];
    description = json['description'];
    image = json['image'];
    createdDate = json['createdDate'];
    publishDateTime = json['publishDateTime'];
    publishStatus = json['publishStatus'];
  }

  // Helper method to safely parse integers
  int? _parseInt(dynamic value) {
    if (value == null) {
      return null;
    } else if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['topicId'] = topicId;
    data['topicName'] = topicName;
    data['topicDescription'] = topicDescription;
    data['materialType'] = materialType;
    data['materialTypeName'] = materialTypeName;
    data['materialTitle'] = materialTitle;
    data['description'] = description;
    data['image'] = image;
    data['createdDate'] = createdDate;
    data['publishDateTime'] = publishDateTime;
    data['publishStatus'] = publishStatus;
    return data;
  }
}
