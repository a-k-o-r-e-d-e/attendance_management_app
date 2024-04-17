import 'package:attendance_management_app/features/class/domain/models/course_class_model.dart';
import 'package:attendance_management_app/shared/utilities/app_colors.dart';
import 'package:attendance_management_app/shared/utilities/size_utils.dart';
import 'package:attendance_management_app/shared/utilities/string_utils.dart';
import 'package:attendance_management_app/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class ClassCard extends StatelessWidget {
  final CourseClassesModel classInstance;

  const ClassCard({super.key, required this.classInstance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.appLight30),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(4)),
          ),
          horizontalSpaceSmall,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: classInstance.title,
                  size: 14,
                  weight: FontWeight.w600,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svgs/clock.svg",
                      colorFilter: const ColorFilter.mode(
                          AppColors.medium200, BlendMode.srcIn),
                    ),
                    horizontalSpace(8),
                    CustomText(
                      title:
                          "${StringUtils.formatTime(classInstance.startTime.toString())} - ${StringUtils.formatTime(classInstance.endTime.toString())}",
                      size: 14,
                      weight: FontWeight.w500,
                    ),
                    horizontalSpace(16),
                    SvgPicture.asset(
                      "assets/svgs/calendar.svg",
                      colorFilter: const ColorFilter.mode(
                          AppColors.medium200, BlendMode.srcIn),
                    ),
                    horizontalSpace(8),
                    CustomText(
                      title:
                          DateFormat('dd/MM').format(classInstance.startDate!),
                      size: 14,
                      weight: FontWeight.w500,
                    ),
                  ],
                )
              ],
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_right_rounded,
            size: 24,
            color: AppColors.medium200,
          )
        ],
      ),
    );
  }
}
