import 'package:attendance_management_app/features/class/domain/models/course_class_model.dart';
import 'package:attendance_management_app/features/course/presentation/providers/get_course_classes_provider.dart';
import 'package:attendance_management_app/features/course/presentation/widgets/class_card.dart';
import 'package:attendance_management_app/shared/utilities/app_colors.dart';
import 'package:attendance_management_app/shared/utilities/size_utils.dart';
import 'package:attendance_management_app/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class ClassTab extends ConsumerWidget {
  final String courseId;

  const ClassTab({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<CourseClassesModel>> getClasses =
        ref.watch(getCourseClassesProvider(courseId));
    return getClasses.when(data: (List<CourseClassesModel> classes) {
      return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 24),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/svgs/class_card.svg"),
                CustomText(
                  title: " Scheduled classes for this course",
                  size: widthSizer(16, context),
                  weight: FontWeight.w400,
                  color: AppColors.medium300,
                ),
              ],
            ),
            verticalSpace(16),
            Visibility(
                visible: classes.isNotEmpty,
                replacement: Column(
                  children: [
                    verticalSpace(heightSizer(16, context)),
                    SvgPicture.asset(
                      "assets/svgs/class_card.svg",
                      width: 56,
                      colorFilter: const ColorFilter.mode(
                          AppColors.appLight30, BlendMode.srcIn),
                    ),
                    verticalSpace(32),
                    const CustomText(
                      title:
                          "No class has been created for this course yet.",
                      size: 20,
                      weight: FontWeight.w400,
                      textAlign: TextAlign.center,
                      color: AppColors.medium200,
                      overflow: TextOverflow.clip,
                    ),
                    verticalSpace(24),
                  ],
                ),
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ClassCard(
                        classInstance: classes[index],
                      );
                    },
                    separatorBuilder: (ctx, idx) => verticalSpace(8),
                    itemCount: classes.length)),
          ],
        ),
      );
    }, error: (Object error, StackTrace stackTrace) {
      print(stackTrace);
      return const Text("An error has occurred!");
    }, loading: () {
      return Shimmer(
        period: const Duration(seconds: 2),
        //Default value
        loop: 1,
        enabled: true,
        //Default value
        direction: ShimmerDirection.ltr,
        gradient:
            LinearGradient(colors: [Colors.white, Colors.grey.withOpacity(.5)]),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.appGrey, borderRadius: BorderRadius.circular(8)),
          width: double.infinity,
          height: heightSizer(318, context),
        ),
      );
    });
  }
}
