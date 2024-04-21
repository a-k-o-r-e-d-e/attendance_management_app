import 'package:attendance_management_app/shared/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ongoing_classes_provider.g.dart';

@Riverpod(keepAlive: true)
class OngoingClass extends _$OngoingClass {
  @override
  Set<String> build() {
    return {};
  }

  void addClass(String classId) {
    state.add(classId);
  }

  void removeClass(String classId) {
    state.remove(classId);
  }
// Add methods to mutate the state
}
