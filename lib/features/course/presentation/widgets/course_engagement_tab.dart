import 'package:attendance_management_app/shared/utilities/app_colors.dart';
import 'package:attendance_management_app/shared/utilities/size_utils.dart';
import 'package:attendance_management_app/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CourseEngagementTab extends StatelessWidget {
  const CourseEngagementTab({
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
            Row(
              children: [
                SvgPicture.asset("assets/svgs/report.svg"),
                horizontalSpace(16),
                Expanded(
                  child: CustomText(
                    title: "Your engagements for this course",
                    size: widthSizer(16, context),
                    weight: FontWeight.w400,
                    color: AppColors.medium300,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                verticalSpace(32),
                SvgPicture.asset(
                  "assets/svgs/course.svg",
                  width: 56,
                  height: 56,
                  colorFilter:
                      const ColorFilter.mode(AppColors.appLight30, BlendMode.srcIn),
                ),
                verticalSpace(32),
                const CustomText(
                  title:
                      "You are not enrolled to this course yet. Enroll now to see course activity.",
                  size: 16,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  color: AppColors.medium200,
                  overflow: TextOverflow.clip,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
