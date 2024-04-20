import 'package:attendance_management_app/shared/routes/app_route.dart';
import 'package:attendance_management_app/shared/utilities/app_colors.dart';
import 'package:attendance_management_app/shared/utilities/size_utils.dart';
import 'package:attendance_management_app/shared/widgets/custom_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../shared/models/user_model.dart';
import '../providers/get_enrolled_student_provider.dart';

class CourseReportTab extends ConsumerWidget {
  final String courseId;

  const CourseReportTab({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Profile>> activity =
        ref.watch(getEnrolledStudentProvider(courseId));
    return activity.when(data: (List<Profile> students) {
      return SizedBox(
        width: screenWidth(context),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 24),
          child: ListView(
            shrinkWrap: true,
            children: [
              GestureDetector(
                onTap: () {
                  context.navigateTo(StudentListRoute(students: students));
                },
                child: Row(
                  children: [
                    SvgPicture.asset("assets/svgs/users-group.svg"),
                    horizontalSpace(16),
                    Expanded(
                      child: CustomText(
                        title:
                            "${students.length} student enrolled for this course",
                        size: widthSizer(16, context),
                        weight: FontWeight.w400,
                        color: AppColors.medium300,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right_rounded,
                      size: 20,
                      color: AppColors.medium300,
                    )
                  ],
                ),
              ),
              verticalSpace(29),
              Row(
                children: [
                  SvgPicture.asset("assets/svgs/class_card.svg"),
                  horizontalSpace(16),
                  Expanded(
                    child: CustomText(
                      title: "0 classes were held so far",
                      size: widthSizer(16, context),
                      weight: FontWeight.w400,
                      color: AppColors.medium300,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              verticalSpace(29),
              Row(
                children: [
                  SvgPicture.asset("assets/svgs/class_card.svg"),
                  horizontalSpace(16),
                  Expanded(
                    child: CustomText(
                      title: "0 classes were canceled so far",
                      size: widthSizer(16, context),
                      weight: FontWeight.w400,
                      color: AppColors.medium300,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              verticalSpace(29),
              Row(
                children: [
                  SvgPicture.asset("assets/svgs/users-group.svg"),
                  horizontalSpace(16),
                  Expanded(
                    child: CustomText(
                      title:
                          "75% of enrolled students have met the minimum attendance requirement",
                      size: widthSizer(16, context),
                      weight: FontWeight.w400,
                      color: AppColors.medium300,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              verticalSpace(29),
              Row(
                children: [
                  SvgPicture.asset("assets/svgs/users-group.svg"),
                  horizontalSpace(16),
                  Expanded(
                    child: CustomText(
                      title:
                          "25% of enrolled students have not met the minimum attendance requirement",
                      size: widthSizer(16, context),
                      weight: FontWeight.w400,
                      color: AppColors.medium300,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }, error: (Object error, StackTrace stackTrace) {
      print(stackTrace);
      return Text(stackTrace.toString());
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
