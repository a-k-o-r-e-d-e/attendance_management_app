import 'package:attendance_management_app/features/course/domain/providers/course_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/course_model.dart';

part 'fetch_courses_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<Course>> fetchCourse(FetchCourseRef ref) async {
  final courseRepo = ref.read(courseRepoProvider);
  return await courseRepo.fetchAllCourse();
}