import 'package:attendance_management_app/features/class/data/repository/meeting_repo_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/providers/meeting_data_provider.dart';


part 'meeting_repo_provider.g.dart';

@riverpod
class MeetingRepo extends _$MeetingRepo {
  @override
  MeetingRepoImpl build() {
    final source = ref.watch(meetingDataProvider);
    return MeetingRepoImpl();
  }
// Add methods to mutate the state
}
