import 'package:attendance_management_app/features/class/domain/providers/meeting_repo_provider.dart';
import 'package:attendance_management_app/shared/utilities/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClassScheduleBottomSheet extends StatelessWidget {
  static show(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        builder: (context) {
          return ClassScheduleBottomSheet._(
            ref: ref,
          );
        });
  }

  const ClassScheduleBottomSheet._({
    Key? key,
    required this.ref,
  }) : super(key: key);
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final dataSource = ref.watch(meetingRepoProvider);
    return Container(
      padding: const EdgeInsets.all(8),
      height: screenHeight(context) / 2,

    );
  }
}
