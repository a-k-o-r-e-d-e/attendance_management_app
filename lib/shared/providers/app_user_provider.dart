import 'package:attendance_management_app/features/authentication/domain/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_user_provider.g.dart';

@riverpod
class AppUser extends _$AppUser {
  @override
  UserAccount build() {
    return UserAccount();
  }
  void setUserType(UserAccount user) {
    state = user;
  }
// Add methods to mutate the state
}