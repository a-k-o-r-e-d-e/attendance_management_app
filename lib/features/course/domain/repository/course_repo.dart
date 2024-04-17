import '../../../../shared/models/user_model.dart';
import '../../../authentication/presentation/providers/states/user_type_state.dart';
import '../../../class/domain/models/course_class_model.dart';
import '../models/course_model.dart';

abstract class CourseRepository {
  Future<List<Course>> fetchAllCourse(UserType userType);

  Future<Course> createCourse(Map<String, dynamic> data);

  Future<List<Profile>> getEnrolledStudents(String courseId);

  Future<bool> enrollCourse(String courseId);

  Future<List<CourseClassesModel>> getCourseClasses(String courseId);

  Future<bool> deleteCourse(String courseId);

  Future<Course> editCourse(
    String courseId,
    Map<String, dynamic> data,
  );

  Future<bool> unEnrollCourse(String courseId);

  Future<List<Course>> fetchAvailableCourses();
}
