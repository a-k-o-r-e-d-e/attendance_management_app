import 'package:attendance_management_app/features/course/presentation/widgets/class_card.dart';
import 'package:attendance_management_app/shared/utilities/app_colors.dart';
import 'package:attendance_management_app/shared/utilities/size_utils.dart';
import 'package:attendance_management_app/shared/widgets/custom_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../domain/models/course_model.dart';

class CourseReportTab extends StatelessWidget {
  const CourseReportTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth(context),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 24),
        child: ListView(
          shrinkWrap: true,
          children: [
            GestureDetector(
              onTap: (){
                context.navigateNamedTo("/student-list");
              },
              child: Row(
                children: [
                  SvgPicture.asset("assets/svgs/users-group.svg"),
                  horizontalSpace(16),
                  Expanded(
                    child: CustomText(
                      title: "1,239 student enrolled for this course",
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
                    title: "20 classes were held so far",
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
                    title: "2 classes were canceled so far",
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
                    title: "75% of enrolled students have met the minimum attendance requirement",
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
                    title: "25% of enrolled students have not met the minimum attendance requirement",
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
  }
}
