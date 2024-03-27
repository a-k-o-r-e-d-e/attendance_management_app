import 'package:attendance_management_app/features/authentication/domain/models/user_model.dart';
import 'package:attendance_management_app/features/course/domain/models/course_model.dart';
import '../../domain/repository/course_repo.dart';
import '../data_source/course_remote_data_source.dart';

class CourseRepositoryImpl extends CourseRepository {
  final CourseDataSource dataSource;

  CourseRepositoryImpl(this.dataSource);

  @override
  Future<List<Course>> fetchAllCourse() {
    return dataSource.fetchAllCourse();
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
}
