import 'package:attendance_management_app/shared/models/user_model.dart';
import 'package:attendance_management_app/features/authentication/presentation/providers/states/user_type_state.dart';

import '../../domain/repository/auth_repo.dart';
import '../data_source/authentication_remote_data_source.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthDataSource dataSource;

  AuthenticationRepositoryImpl(this.dataSource);

  @override
  Future<UserAccount> createUser(
      Map<String, dynamic> userData, UserType userType) {
    return dataSource.createAccount(userData: userData, userType: userType);
  }

  @override
  Future<UserAccount> login(Map<String, dynamic> userData) {
    return dataSource.login(userData: userData);
  }

  @override
  Future<UserAccount> authenticate(Map<String, dynamic> userData) {
    return dataSource.authenticate(userData);
  }
}
