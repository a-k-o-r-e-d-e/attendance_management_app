import 'package:attendance_management_app/features/class/domain/models/course_class_model.dart';
import 'package:attendance_management_app/features/course/domain/providers/course_repo_provider.dart';
import 'package:attendance_management_app/features/course/domain/repository/course_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_course_classes_provider.g.dart';

@Riverpod()
Future<List<CourseClassesModel>> getCourseClasses(GetCourseClassesRef ref, String courseId) async {
  final CourseRepository courseRepo = ref.read(courseRepoProvider);
  return await courseRepo.getCourseClasses(courseId);
}
