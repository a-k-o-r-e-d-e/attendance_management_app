import 'package:attendance_management_app/features/class/domain/models/meeting_model.dart';
import 'package:attendance_management_app/features/home/domain/providers/home_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'class_schedule_provider.g.dart';

@riverpod
class ClassSchedule extends _$ClassSchedule {
  @override
  Future<List<Meeting>> build() async {

    final homeRepo = ref.watch(homeRepositoryProvider);
    final data = await homeRepo.getUpcomingClass();
    throw data;
  }

// Add methods to mutate the state
}
