import 'package:attendance_management_app/shared/models/user_model.dart';
import 'package:attendance_management_app/features/authentication/presentation/providers/states/user_type_state.dart';
import '../../domain/repository/profile_repo.dart';
import '../data_source/profile_remote_data_source.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileDataSource dataSource;

  ProfileRepositoryImpl(this.dataSource);

  @override
  Future<Profile> fetchMyProfile(UserType userType) {
    return dataSource.fetchMyProfile(userType);
  }

  @override
  Future<Profile> fetchProfileById(UserType userType, String id) {
    return dataSource.fetchProfileById(userType, id);
  }

  @override
  Future<Profile> updateProfile(
      UserType userType, Map<String, dynamic> userData) {
    return dataSource.updateProfile(userType, userData);
  }
}
