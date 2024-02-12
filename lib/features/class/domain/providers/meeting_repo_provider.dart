import 'package:attendance_management_app/features/class/data/repository/meeting_repo_impl.dart';
import 'package:attendance_management_app/features/class/domain/providers/meeting_data_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


part 'meeting_repo_provider.g.dart';

@riverpod
class MeetingRepo extends _$MeetingRepo {
  @override
  CalendarDataSource build() {
    final source = ref.watch(meetingDataProvider);
    return MeetingRepoImpl(source);
  }
// Add methods to mutate the state
}
