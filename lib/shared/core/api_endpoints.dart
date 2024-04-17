class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl =
      "https://attendio-api-146c740682dd.herokuapp.com/api/";
  static const String registerLecturer = "${baseUrl}auth/register/lecturer";
  static const String registerStudent = "${baseUrl}auth/register/student";
  static const String login = "${baseUrl}auth/login";
  static const String authenticate = "${baseUrl}auth/token";
  static const String institutions = "${baseUrl}institutions/search";

  static const String getLecturerProfileById = "${baseUrl}lecturers";
  static const String getLecturerProfile = "${baseUrl}lecturers/me";

  static const String getStudentProfileById = "${baseUrl}students";
  static const String getStudentProfile = "${baseUrl}students/me";
  static const String getStudentCourses = "${baseUrl}students/me/courses";
  static const String getStudentClasses =
      "${baseUrl}students/me/classes/instances";

  static const String getLecturerCourses = "${baseUrl}lecturers/me/courses";
  static const String getLecturerClasses =
      "${baseUrl}lecturers/me/classes/instances";
  static const String getCourses = "${baseUrl}courses";
  static const String searchCourses = "${baseUrl}courses/search";

  static const String classes = "${baseUrl}classes";
}
