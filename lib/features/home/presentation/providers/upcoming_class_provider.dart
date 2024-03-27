import 'package:attendance_management_app/features/home/domain/providers/home_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/model/upcoming_class_model.dart';

part 'upcoming_class_provider.g.dart';

@riverpod
class UpcomingClass extends _$UpcomingClass {
  @override
  Future<List<UpcomingClassModel>> build() async {
    final homeRepo = ref.watch(homeRepositoryProvider);
    final data = await homeRepo.getUpcomingClass();
    return data;
  }

// Add methods to mutate the state
}
