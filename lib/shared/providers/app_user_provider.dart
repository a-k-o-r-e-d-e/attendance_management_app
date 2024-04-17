import 'package:attendance_management_app/shared/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_user_provider.g.dart';

@Riverpod(keepAlive: true)
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