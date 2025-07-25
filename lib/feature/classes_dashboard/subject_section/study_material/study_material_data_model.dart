
class StudyMaterialTopicDataModel {
  int? id;
  int? topicId;
  String? topicName;
  String? topicDescription;
  int? materialType;
  String? materialTypeName;
  String? materialTitle;
  Null? description;
  String? image;
  String? createdDate;
  String? publishDateTime;
  String? publishStatus;

  StudyMaterialTopicDataModel(
      {this.id,
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
        this.publishStatus});

  StudyMaterialTopicDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topicId = json['topicId'];
    topicName = json['topicName'];
    topicDescription = json['topicDescription'];
    materialType = json['materialType'];
    materialTypeName = json['materialTypeName'];
    materialTitle = json['materialTitle'];
    description = json['description'];
    image = json['image'];
    createdDate = json['createdDate'];
    publishDateTime = json['publishDateTime'];
    publishStatus = json['publishStatus'];
  }

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
