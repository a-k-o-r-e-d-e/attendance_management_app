import 'package:attendance_management_app/features/authentication/presentation/providers/states/user_type_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_user_state_provider.g.dart';

@riverpod
class LoginUserType extends _$LoginUserType {
  @override
  UserType build() {
    return UserType.none;
  }

  void setUserType(UserType type) {
    state = type;
  }

// Add methods to mutate the state
}
