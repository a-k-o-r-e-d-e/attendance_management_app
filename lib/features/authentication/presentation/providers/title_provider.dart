import 'package:attendance_management_app/features/authentication/presentation/providers/states/user_type_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'title_provider.g.dart';

@riverpod
class TitleType extends _$TitleType {

  @override
  TitleEnum build() {
    return TitleEnum.none;
  }

  void setTitle(TitleEnum type) {
    state = type;
  }

// Add methods to mutate the state
}
