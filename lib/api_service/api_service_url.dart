


class ApiServiceUrl{


  static String apiBaseUrl= "https://elearningapi.edumation.in/api/";
  static String urlLauncher = "https://elearningapi.edumation.in/FileUploads/";


  static String login = "User/Login";
  static String generateOtp = "User/GenerateOtp";
  static String verifyOtp = "User/VerifyOtp";
  static String forgotPassword = "User/ForgotPassword";
  static String getUserRole = "User/GetUserRole";
  static String sessionDetails = "SessionDetails";
  static String loginWithInstitute = "User/LoginWithInstitute";

  static String getStudentAttendanceByClgBatchSessionId = "CollegeReports/GetStudentAttendanceByClgBatchSessionId";
  static String getStudentModuleAndTopic = "Student/GetStudentModuleAndTopic";
  static String getAllPublishStudyMaterial = "StudyMaterial/GetAllPublishStudyMaterial";
  static String getStudentAttendanceByCourseId = "Attendance/getStudentAttendanceByCourseId";
  static String getNotice = "Notice/GetNotice";
  static String getMcQ = "AssigementRevision/getMcQ";
  static String getSubjective = "AssigementRevision/getSubjective";
  static String getMcQByModule = "AssigementRevision/GetMcQByModule";
  static String submitQuestion = "AssigementRevision/SubmitQuestion";

  static String getAttandenceReportByStudentId = "Report/GetAttandenceReportByStudentId";
  static String getAssignmentReportByStudentId = "Report/AssignmentReportByStudentId";

  static String getAllForum = "Forum/getAllForum";
  static String getAllThread = "Forum/getAllthread";
  static String likeThread = "Forum/likeThread?threadId";
  static String addThreadComment = "Forum/AddThreadComment";
  static String getAllComments = "Forum/GetAllComments";
  static String addThreadPost = "Forum/AddThreadPost";


}