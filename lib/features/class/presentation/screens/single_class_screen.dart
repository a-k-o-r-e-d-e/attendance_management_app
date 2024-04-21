import 'package:attendance_management_app/features/class/presentation/widgets/lecturer_class%20screen.dart';
import 'package:attendance_management_app/features/class/presentation/widgets/student_class_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/base_model.dart';
import '../../../../shared/providers/app_user_provider.dart';

@RoutePage()
class SingleClassScreen extends ConsumerWidget {
  final Base classInstance;
  final String classID;

  const SingleClassScreen({
    super.key,
    required this.classInstance,
    required this.classID,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? appUser = ref.watch(appUserProvider).profile?.user?.roles![0];

    return appUser == 'lecturer'
        ? LecturerClassScreen(
            classInstance: classInstance,
            classID: classID,
          )
        : StudentClassScreen(
            classInstance: classInstance,
            classID: classID,
          );
  }
}
