import 'package:attendance_management_app/shared/models/user_model.dart';
import 'package:attendance_management_app/features/class/domain/models/course_class_model.dart';
import 'package:attendance_management_app/features/course/domain/models/course_model.dart';
import '../../../authentication/presentation/providers/states/user_type_state.dart';
import '../../domain/repository/course_repo.dart';
import '../data_source/course_remote_data_source.dart';

class CourseRepositoryImpl extends CourseRepository {
  final CourseDataSource dataSource;

  CourseRepositoryImpl(this.dataSource);

  @override
  Future<List<Course>> fetchAllCourse(UserType userType) {
    return dataSource.fetchAllCourse(userType);
  }

  @override
  Future<Course> createCourse(Map<String, dynamic> data) {
    return dataSource.createCourse(data);
  }

  @override
  Future<List<Profile>> getEnrolledStudents(String courseId) {
    return dataSource.getEnrolledStudents(courseId);
  }

  @override
  Future<bool> enrollCourse(String courseId) {
    return dataSource.enrollCourse(courseId);
  }

  @override
  Future<List<CourseClassesModel>> getCourseClasses(String courseId) {
    return dataSource.getCourseClasses(courseId);
  }

  @override
  Future<bool> deleteCourse(String courseId) {
    return dataSource.deleteCourse(courseId);
  }

  @override
  Future<Course> editCourse(String courseId, Map<String, dynamic> data) {
    return dataSource.editCourse(courseId, data);
  }

  @override
  Future<List<Course>> fetchAvailableCourses() {
    return dataSource.fetchAvailableCourses();
  }

  @override
  Future<bool> unEnrollCourse(String courseId) {
    return dataSource.unEnrollCourse(courseId);
  }
}
