import 'package:attendance_management_app/features/course/domain/providers/course_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/models/user_model.dart';

part 'get_enrolled_student_provider.g.dart';

@Riverpod()
Future<List<Profile>> getEnrolledStudent(GetEnrolledStudentRef ref, String courseId) async {
  final courseRepo = ref.read(courseRepoProvider);
  return await courseRepo.getEnrolledStudents(courseId);
}