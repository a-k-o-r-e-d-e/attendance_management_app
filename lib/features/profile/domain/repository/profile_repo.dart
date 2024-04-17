import 'package:attendance_management_app/shared/models/user_model.dart';

import '../../../authentication/presentation/providers/states/user_type_state.dart';

abstract class ProfileRepository {
  Future<Profile> fetchMyProfile(UserType userType);

  Future<Profile> updateProfile(
      UserType userType, Map<String, dynamic> userData);

  Future<Profile> fetchProfileById(UserType userType, String id);
}
