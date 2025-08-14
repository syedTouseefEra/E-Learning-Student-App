import 'package:e_learning/api_service/api_calling_types.dart';
import 'package:e_learning/api_service/api_service_url.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final ApiCallingTypes apiCallingTypes;

  AuthService({required this.apiCallingTypes});

  Future<http.Response> loginUser(String mobile, String password) async {
    final String url = '${apiCallingTypes.baseUrl}${ApiServiceUrl.login}';

    final body = {
      'mobileNo': mobile,
      'password': password,
    };

    return await apiCallingTypes.postApiCall(
      url: url,
      body: body,
    );
  }

  Future<http.Response> generateOtp({required String mobileNo}) async {
    final String url = '${apiCallingTypes.baseUrl}${ApiServiceUrl.generateOtp}';
    return await apiCallingTypes.postApiCall(
      url: url,
      body: {
        'mobileNo': mobileNo,
      },
    );
  }

  Future<http.Response> verifyOtp(
      {required String mobileNo, required String otp}) async {
    final String url = '${apiCallingTypes.baseUrl}${ApiServiceUrl.verifyOtp}';
    return await apiCallingTypes.putApiCall(
      url: url,
      body: {
        'mobileNo': mobileNo,
        'otp': otp,
      },
    );
  }

  Future<http.Response> forgotPassword(
      {required String token, required String newPassword}) async {
    final String url =
        '${apiCallingTypes.baseUrl}${ApiServiceUrl.forgotPassword}';
    return await apiCallingTypes.putApiCall(
      url: url,
      body: {
        'newPassword': newPassword,
      },
      token: token,
    );
  }

  Future<http.Response> getUserRole({required String token}) async {
    final String url = '${apiCallingTypes.baseUrl}${ApiServiceUrl.getUserRole}';

    return await apiCallingTypes.getApiCall(
      url: url,
      token: token,
    );
  }

  Future<http.Response> getStudentSessionDetails(
      {required String token, required int instituteId}) async {
    final String url =
        '${apiCallingTypes.baseUrl}${ApiServiceUrl.sessionDetails}';
    return await apiCallingTypes.getApiCall(
      url: url,
      params: {'instituteId': instituteId.toString()},
      token: token,
    );
  }

  Future<http.Response> getDashboardData({
    required String token,
    required int organizationId,
    required int instituteId,
    required int userRoleId,
  }) async {
    final String url =
        '${apiCallingTypes.baseUrl}${ApiServiceUrl.loginWithInstitute}';

    return await apiCallingTypes.postApiCall(
      url: url,
      body: {
        "organizationId": organizationId,
        "instituteId": instituteId,
        "userRoleId": userRoleId,
      },
      token: token,
    );
  }

  Future<http.Response> getDashboardAttendanceData({
    required String token,
    required int requestType,
  }) async {
    final String url =
        '${apiCallingTypes.baseUrl}${ApiServiceUrl.studentGetAllCourseAttandence}';

    return await apiCallingTypes.getApiCall(
      url: url,
      params: {
        "requestType": requestType.toString(),
      },
      token: token,
     );
  }

  Future<http.Response> getDashboardAssignmentData({
    required String token,
    required int type,
  }) async {
    final String url =
    '${apiCallingTypes.baseUrl}${ApiServiceUrl.studentGetAllIncompletedAssigement}';
    return await apiCallingTypes.getApiCall(
      url: url,
      params: {
        "type": type.toString(),
      },
      token: token,
    );
  }

  Future<http.Response> getStudentModuleAndTopic(
      {required String token}) async {
    final String url =
        '${apiCallingTypes.baseUrl}${ApiServiceUrl.getStudentModuleAndTopic}';

    return await apiCallingTypes.getApiCall(
      url: url,
      token: token,
    );
  }

  Future<http.Response> getAllPublishStudyMaterial(
      {required String token, required String topicId}) async {
    final String url =
        '${apiCallingTypes.baseUrl}${ApiServiceUrl.getAllPublishStudyMaterial}';
    return await apiCallingTypes.getApiCall(
      url: url,
      params: {'topicId': topicId},
      token: token,
    );
  }

  Future<http.Response> getStudentAttendanceByCourseId(
      {required String token,
      required String startDate,
      required String endDate,
      required String courseId,
      required String studentId,
      required String batchId}) async {
    final String url =
        '${apiCallingTypes.baseUrl}${ApiServiceUrl.getStudentAttendanceByCourseId}';
    return await apiCallingTypes.getApiCall(
      url: url,
      params: {
        'startDate': startDate,
        'endDate': endDate,
        'courseId': courseId,
        'studentId': studentId,
        'batchId': batchId
      },
      token: token,
    );
  }

  Future<http.Response> getNotice(
      {required String token,
      required String courseId,
      required String sessionId,
      required String instituteId,
      required String batchId}) async {
    final String url = '${apiCallingTypes.baseUrl}${ApiServiceUrl.getNotice}';
    return await apiCallingTypes.getApiCall(
      url: url,
      params: {
        'courseId': courseId,
        'sessionId': sessionId,
        'instituteId': instituteId,
        'batchId': batchId
      },
      token: token,
    );
  }

  Future<http.Response> getMcQ(
      {required String token,
      required bool isMcq,
      required String courseId,
      required String topicId,
      required String moduleId,
      required String batchId}) async {
    final String url =
        '${apiCallingTypes.baseUrl}${isMcq == true ? ApiServiceUrl.getMcQ : ApiServiceUrl.getSubjective}';
    return await apiCallingTypes.getApiCall(
      url: url,
      params: {
        'courseId': courseId,
        'moduleId': moduleId,
        'topicId': topicId,
        'batchId': batchId
      },
      token: token,
    );
  }

  Future<http.Response> getMcQByModule(
      {required String token,
      required String courseId,
      required String moduleId,
      required String batchId}) async {
    final String url =
        '${apiCallingTypes.baseUrl}${ApiServiceUrl.getMcQByModule}';
    return await apiCallingTypes.getApiCall(
      url: url,
      params: {'courseId': courseId, 'moduleId': moduleId, 'batchId': batchId},
      token: token,
    );
  }

  Future<http.Response> submitAssignment(
      {required String token,
      required int scheduleId,
      required String questionList}) async {
    final String url =
        '${apiCallingTypes.baseUrl}${ApiServiceUrl.submitQuestion}';
    return await apiCallingTypes.postApiCall(
      url: url,
      body: {
        'scheduleId': scheduleId,
        'questionList': questionList,
      },
      token: token,
    );
  }

  Future<http.Response> getAttendanceReport(
      {required String token,
      required String startDate,
      required String endDate,
      required String courseId,
      required String instituteId,
      required String batchId}) async {
    final String url =
        '${apiCallingTypes.baseUrl}${ApiServiceUrl.getAttandenceReportByStudentId}';
    return await apiCallingTypes.getApiCall(
      url: url,
      params: {
        'startDate': startDate,
        'endDate': endDate,
        'courseId': courseId,
        'instituteId': instituteId,
        'batchId': batchId
      },
      token: token,
    );
  }

  Future<http.Response> getAssignmentReport(
      {required String token,
      required String courseId,
      required String instituteId,
      required String batchId}) async {
    final String url =
        '${apiCallingTypes.baseUrl}${ApiServiceUrl.getAssignmentReportByStudentId}';
    return await apiCallingTypes.getApiCall(
      url: url,
      params: {
        'courseId': courseId,
        'instituteId': instituteId,
        'batchId': batchId
      },
      token: token,
    );
  }

  Future<http.Response> getDiscussionForumData(
      {required String token,
      required String courseId,
      required String batchId}) async {
    final String url = '${apiCallingTypes.baseUrl}${ApiServiceUrl.getAllForum}';
    return await apiCallingTypes.getApiCall(
      url: url,
      params: {'courseId': courseId, 'batchId': batchId},
      token: token,
    );
  }

  Future<http.Response> getAllThread(
      {required String token, required String forumId}) async {
    final String url =
        '${apiCallingTypes.baseUrl}${ApiServiceUrl.getAllThread}';
    return await apiCallingTypes.getApiCall(
      url: url,
      params: {'forumId': forumId},
      token: token,
    );
  }

  Future<http.Response> likeThread(
      {required String token, required int threadId}) async {
    final String url = '${apiCallingTypes.baseUrl}${ApiServiceUrl.likeThread}';
    return await apiCallingTypes.postApiCall(
      url: url,
      body: {
        'threadId': threadId,
      },
      token: token,
    );
  }

  Future<http.Response> addThreadPost(
      {required String token,
      required int forumId,
      required String title,
      required String body}) async {
    final String url =
        '${apiCallingTypes.baseUrl}${ApiServiceUrl.addThreadPost}';
    return await apiCallingTypes.postApiCall(
      url: url,
      body: {
        'forumId': forumId,
        'title': title,
        'body': body,
      },
      token: token,
    );
  }

  Future<http.Response> addThreadComment(
      {required String token,
      required String threadComment,
      required int threadId}) async {
    final String url =
        '${apiCallingTypes.baseUrl}${ApiServiceUrl.addThreadComment}';
    return await apiCallingTypes.postApiCall(
      url: url,
      body: {
        'threadId': threadId,
        'threadComment': threadComment,
      },
      token: token,
    );
  }

  Future<http.Response> getAllThreadComment(
      {required String token, required String threadId}) async {
    final String url =
        '${apiCallingTypes.baseUrl}${ApiServiceUrl.getAllComments}';
    return await apiCallingTypes.getApiCall(
      url: url,
      params: {'threadId': threadId},
      token: token,
    );
  }

  Future<http.Response> likeThreadComment(
      {required String token, required int commentId}) async {
    final String url =
        '${apiCallingTypes.baseUrl}${ApiServiceUrl.likeThreadComment}';
    return await apiCallingTypes.postApiCall(
      url: url,
      body: {
        'commentId': commentId,
      },
      token: token,
    );
  }

  Future<http.Response> addThreadCommentReply(
      {required String token,
      required int commentId,
      required String reply}) async {
    final String url =
        '${apiCallingTypes.baseUrl}${ApiServiceUrl.addThreadCommentReply}';
    return await apiCallingTypes.postApiCall(
      url: url,
      body: {
        'commentId': commentId,
        'reply': reply,
      },
      token: token,
    );
  }

  Future<http.Response> likeThreadCommentReply(
      {required String token, required int replyId}) async {
    final String url =
        '${apiCallingTypes.baseUrl}${ApiServiceUrl.likeThreadCommentReply}';
    return await apiCallingTypes.postApiCall(
      url: url,
      body: {
        'replyId': replyId,
      },
      token: token,
    );
  }
}
