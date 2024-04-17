import 'package:attendance_management_app/features/authentication/presentation/providers/states/user_type_state.dart';
import 'package:attendance_management_app/features/class/domain/providers/class_repo_provider.dart';
import 'package:attendance_management_app/features/class/domain/repository/class_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/upcoming_class_model.dart';

part 'get_classes_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<UpcomingClassModel>> getClasses(
    GetClassesRef ref, UserType userType) async {
  final ClassRepository classRepo = ref.read(classRepoProvider);
  return await classRepo.fetchClasses(userType);
}
