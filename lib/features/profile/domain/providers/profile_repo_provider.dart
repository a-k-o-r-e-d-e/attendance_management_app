import 'package:attendance_management_app/features/profile/data/data_provider/profile_data_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/data_source/profile_remote_data_source.dart';
import '../../data/repository/profile_repo_impl.dart';
import '../repository/profile_repo.dart';

part 'profile_repo_provider.g.dart';

@riverpod
class ProfileRepo extends _$ProfileRepo {
  @override
  ProfileRepository build() {
    final ProfileDataSource dataSource = ref.read(profileDataProvider);
    return ProfileRepositoryImpl(dataSource);
  }
// Add methods to mutate the state
}
