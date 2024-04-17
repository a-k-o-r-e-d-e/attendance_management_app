import 'package:attendance_management_app/features/class/data/providers/class_data_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/data_source/class_remote_data_source.dart';
import '../../data/repository/class_repo_impl.dart';
import '../repository/class_repo.dart';

part 'class_repo_provider.g.dart';

@riverpod
class ClassRepo extends _$ClassRepo {
  @override
  ClassRepository build() {
    final ClassDataSource dataSource = ref.read(classDataProvider);
    return ClassRepoImpl(dataSource);
  }
// Add methods to mutate the state
}
