import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/model/upcoming_class_model.dart';

part 'upcoming_class_provider.g.dart';

@riverpod
class UpcomingClass extends _$UpcomingClass {
  @override
  Future<List<UpcomingClassModel>> build() async {
    return Future.delayed(
        const Duration(seconds: 3),
        () => [
              UpcomingClassModel(
                  courseTitle: "Introduction to Computer (FSC112)",
                  studentEnrolled: 82,
                  startDate: DateTime.now(),
                  coverImage: "")
            ]);
  }

// Add methods to mutate the state
}
