import '../../../authentication/domain/models/user_model.dart';
import '../models/course_model.dart';

abstract class CourseRepository {
  Future<List<Course>> fetchAllCourse();
  Future<Course> createCourse(Map<String, dynamic> data);
  Future<List<Profile>> getEnrolledStudents(String courseId);
  Future<bool> enrollCourse(String courseId);
}
