import 'package:attendance_management_app/features/authentication/presentation/providers/states/user_type_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gender_provider.g.dart';

@riverpod
class GenderType extends _$GenderType {
  @override
  GenderEnum build() {
    return GenderEnum.none;
  }

  void setGender(GenderEnum type) {
    state = type;
  }

// Add methods to mutate the state
}
