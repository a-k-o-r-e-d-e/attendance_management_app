import 'package:attendance_management_app/shared/utilities/app_colors.dart';
import 'package:attendance_management_app/shared/utilities/size_utils.dart';
import 'package:attendance_management_app/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClassCard extends StatelessWidget {
  const ClassCard({super.key});

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                title: "Overview of Computer Science",
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
                  const CustomText(
                    title: "08 - 10AM",
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
                  const CustomText(
                    title: "15/02",
                    size: 14,
                    weight: FontWeight.w500,
                  ),
                ],
              )
            ],
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
