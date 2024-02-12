import 'package:attendance_management_app/features/class/data/data_source/meeting_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repository/meeting_data_repo.dart';

part 'meeting_data_provider.g.dart';

@riverpod
class MeetingData extends _$MeetingData {
  @override
  MeetingDataRepository build() {

    return MeetingDataSource();
  }
// Add methods to mutate the state
}
