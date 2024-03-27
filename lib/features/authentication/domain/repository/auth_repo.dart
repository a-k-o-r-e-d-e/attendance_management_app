import 'package:attendance_management_app/features/authentication/domain/models/user_model.dart';

import '../../presentation/providers/states/user_type_state.dart';

abstract class AuthenticationRepository {
  Future<UserAccount> createUser(Map<String,dynamic> userData, UserType userType);
  Future<UserAccount> login(Map<String,dynamic> userData);
  Future<UserAccount> authenticate();

}
