
class MCQDataModel {
  int? scheduleId;
  int? courseId;
  int? moduleId;
  int? topicId;
  String? startDateTime;
  int? isAttempt;
  int? batchId;
  int? assignmentType;
  List<QuestionList>?  questionList;

  MCQDataModel(
      {this.scheduleId,
        this.courseId,
        this.moduleId,
        this.topicId,
        this.startDateTime,
        this.isAttempt,
        this.batchId,
        this.assignmentType,
        this.questionList});

  MCQDataModel.fromJson(Map<String, dynamic> json) {
    scheduleId = json['scheduleId'];
    courseId = json['courseId'];
    moduleId = json['moduleId'];
    topicId = json['topicId'];
    startDateTime = json['startDateTime'];
    isAttempt = json['isAttempt'];
    batchId = json['batchId'];
    assignmentType = json['assignmentType'];
    if (json['questionList'] != null) {
      questionList = <QuestionList>[];
      json['questionList'].forEach((v) {
        questionList!.add(QuestionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scheduleId'] = scheduleId;
    data['courseId'] = courseId;
    data['moduleId'] = moduleId;
    data['topicId'] = topicId;
    data['startDateTime'] = startDateTime;
    data['isAttempt'] = isAttempt;
    data['batchId'] = batchId;
    data['assignmentType'] = assignmentType;
    if (questionList != null) {
      data['questionList'] = questionList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionList {
  int? scheduleQuestionId;
  String? question;
  String? subjectiveFile;
  int? studentAnswerType;
  int? objectiveType;
  double? marks;
  List<OptionList>? optionList;

  QuestionList(
      {this.scheduleQuestionId,
        this.question,
        this.subjectiveFile,
        this.studentAnswerType,
        this.objectiveType,
        this.marks,
        this.optionList});

  QuestionList.fromJson(Map<String, dynamic> json) {
    scheduleQuestionId = json['scheduleQuestionId'];
    question = json['question'];
    subjectiveFile = json['subjectiveFile'];
    studentAnswerType = json['studentAnswerType'];
    objectiveType = json['objectiveType'];
    marks = json['marks'];
    if (json['optionList'] != null) {
      optionList = <OptionList>[];
      json['optionList'].forEach((v) {
        optionList!.add(OptionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scheduleQuestionId'] = scheduleQuestionId;
    data['question'] = question;
    data['subjectiveFile'] = subjectiveFile;
    data['studentAnswerType'] = studentAnswerType;
    data['objectiveType'] = objectiveType;
    data['marks'] = marks;
    if (optionList != null) {
      data['optionList'] = optionList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OptionList {
  int? assignmentQuestionId;
  int? assignmentOptionId;
  String? txtOption;
  String? imgOption;
  int? isTrue;
  int? resultId;

  OptionList(
      {this.assignmentQuestionId,
        this.assignmentOptionId,
        this.txtOption,
        this.imgOption,
        this.isTrue,
        this.resultId});

  OptionList.fromJson(Map<String, dynamic> json) {
    assignmentQuestionId = json['assignmentQuestionId'];
    assignmentOptionId = json['assignmentOptionId'];
    txtOption = json['txtOption'];
    imgOption = json['imgOption'];
    isTrue = json['isTrue'];
    resultId = json['resultId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assignmentQuestionId'] = assignmentQuestionId;
    data['assignmentOptionId'] = assignmentOptionId;
    data['txtOption'] = txtOption;
    data['imgOption'] = imgOption;
    data['isTrue'] = isTrue;
    data['resultId'] = resultId;
    return data;
  }
}
