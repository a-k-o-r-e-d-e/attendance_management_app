import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_provider.g.dart';

@riverpod
class Onboarding extends _$Onboarding {
  @override
  int build() {
    return 0;
  }

  void setCurrentPage(int page) {
    state = page;
  }

// Add methods to mutate the state
}
