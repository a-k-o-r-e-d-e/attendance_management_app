import 'package:attendance_management_app/features/course/domain/providers/course_repo_provider.dart';
import 'package:attendance_management_app/features/course/domain/repository/course_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../course/domain/models/course_model.dart';

part 'available_courses_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<Course>> getAvailableCourses(GetAvailableCoursesRef ref) async {
  final CourseRepository courseRepo = ref.read(courseRepoProvider);
  return await courseRepo.fetchAvailableCourses();
}
