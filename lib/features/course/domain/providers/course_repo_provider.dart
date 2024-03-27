import 'package:attendance_management_app/features/course/data/providers/course_data_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/data_source/course_remote_data_source.dart';
import '../../data/repository/course_repo_impl.dart';
import '../repository/course_repo.dart';

part 'course_repo_provider.g.dart';

@riverpod
class CourseRepo extends _$CourseRepo {
  @override
  CourseRepository build() {
    final CourseDataSource dataSource = ref.read(courseDataProvider);
    return CourseRepositoryImpl(dataSource);
  }
// Add methods to mutate the state
}
