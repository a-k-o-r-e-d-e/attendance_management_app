import 'package:attendance_management_app/features/authentication/data/data_source/authentication_remote_data_source.dart';
import 'package:attendance_management_app/features/authentication/data/providers/auth_data_provider.dart';
import 'package:attendance_management_app/features/authentication/data/repository/auth_repo_impl.dart';
import 'package:attendance_management_app/features/authentication/domain/repository/auth_repo.dart';
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
