

class ClassDashboardDataModel {
  int? id;
  int? courseId;
  String? courseName;
  String? courseShortName;
  String? courseCode;
  int? durationTypeId;
  String? courseDurationTypeName;
  int? batchId;
  String? batchName;
  String? startDate;
  String? endDate;
  String? classType;
  int? courseCategoryId;
  String? courseCategory;
  int? courseTypeId;
  String? courseType;
  String? courseDescription;
  String? courseImage;
  int? maximumSizeUpload;
  List<ModuleList>? moduleList;

  ClassDashboardDataModel(
      {this.id,
        this.courseId,
        this.courseName,
        this.courseShortName,
        this.courseCode,
        this.durationTypeId,
        this.courseDurationTypeName,
        this.batchId,
        this.batchName,
        this.startDate,
        this.endDate,
        this.classType,
        this.courseCategoryId,
        this.courseCategory,
        this.courseTypeId,
        this.courseType,
        this.courseDescription,
        this.courseImage,
        this.maximumSizeUpload,
        this.moduleList});

  ClassDashboardDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['courseId'];
    courseName = json['courseName'];
    courseShortName = json['courseShortName'];
    courseCode = json['courseCode'];
    durationTypeId = json['durationTypeId'];
    courseDurationTypeName = json['courseDurationTypeName'];
    batchId = json['batchId'];
    batchName = json['batchName'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    classType = json['classType'];
    courseCategoryId = json['courseCategoryId'];
    courseCategory = json['courseCategory'];
    courseTypeId = json['courseTypeId'];
    courseType = json['courseType'];
    courseDescription = json['courseDescription'];
    courseImage = json['courseImage'];
    maximumSizeUpload = json['maximumSizeUpload'];
    if (json['moduleList'] != null) {
      moduleList = <ModuleList>[];
      json['moduleList'].forEach((v) {
        moduleList!.add(ModuleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['courseId'] = courseId;
    data['courseName'] = courseName;
    data['courseShortName'] = courseShortName;
    data['courseCode'] = courseCode;
    data['durationTypeId'] = durationTypeId;
    data['courseDurationTypeName'] = courseDurationTypeName;
    data['batchId'] = batchId;
    data['batchName'] = batchName;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['classType'] = classType;
    data['courseCategoryId'] = courseCategoryId;
    data['courseCategory'] = courseCategory;
    data['courseTypeId'] = courseTypeId;
    data['courseType'] = courseType;
    data['courseDescription'] = courseDescription;
    data['courseImage'] = courseImage;
    data['maximumSizeUpload'] = maximumSizeUpload;
    if (moduleList != null) {
      data['moduleList'] = moduleList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ModuleList {
  int? courseId;
  String? courseName;
  int? moduleId;
  String? moduleName;
  String? learnDetails;
  String? skillGain;
  List<TopicList>? topicList;

  ModuleList(
      {this.courseId,
        this.courseName,
        this.moduleId,
        this.moduleName,
        this.learnDetails,
        this.skillGain,
        this.topicList});

  ModuleList.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    courseName = json['courseName'];
    moduleId = json['moduleId'];
    moduleName = json['moduleName'];
    learnDetails = json['learnDetails'];
    skillGain = json['skillGain'];
    if (json['topicList'] != null) {
      topicList = <TopicList>[];
      json['topicList'].forEach((v) {
        topicList!.add(TopicList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['courseId'] = courseId;
    data['courseName'] = courseName;
    data['moduleId'] = moduleId;
    data['moduleName'] = moduleName;
    data['learnDetails'] = learnDetails;
    data['skillGain'] = skillGain;
    if (topicList != null) {
      data['topicList'] = topicList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopicList {
  int? topicId;
  String? topicName;
  String? topicDescription;
  int? moduleId;
  String? moduleName;
  int? teacherId;
  String? teacherName;
  String? startDate;
  String? endDate;
  int? videoCount;
  int? readingCount;
  int? imageCount;
  int? audioCount;
  int? isAssignment;

  TopicList(
      {this.topicId,
        this.topicName,
        this.topicDescription,
        this.moduleId,
        this.moduleName,
        this.teacherId,
        this.teacherName,
        this.startDate,
        this.endDate,
        this.videoCount,
        this.readingCount,
        this.imageCount,
        this.audioCount,
        this.isAssignment});

  TopicList.fromJson(Map<String, dynamic> json) {
    topicId = json['topicId'] ?? 0;
    topicName = json['topicName'] ?? '';
    topicDescription = json['topicDescription'] ?? '';
    moduleId = json['moduleId'] ?? 0;
    moduleName = json['moduleName'] ?? '';
    teacherId = json['teacherId'] ?? 0;
    teacherName = json['teacherName'] ?? '';
    startDate = json['startDate'] ?? '';
    endDate = json['endDate'] ?? '';
    videoCount = json['videoCount'] ?? 0;
    readingCount = json['readingCount'] ?? 0;
    imageCount = json['imageCount'] ?? 0;
    audioCount = json['audioCount'] ?? 0;
    isAssignment = json['isAssignment'] ?? 0;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['topicId'] = topicId;
    data['topicName'] = topicName;
    data['topicDescription'] = topicDescription;
    data['moduleId'] = moduleId;
    data['moduleName'] = moduleName;
    data['teacherId'] = teacherId;
    data['teacherName'] = teacherName;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['videoCount'] = videoCount;
    data['readingCount'] = readingCount;
    data['imageCount'] = imageCount;
    data['audioCount'] = audioCount;
    data['isAssignment'] = isAssignment;
    return data;
  }
}
