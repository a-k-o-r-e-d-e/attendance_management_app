import 'package:attendance_management_app/features/course/presentation/widgets/class_card.dart';
import 'package:attendance_management_app/shared/utilities/app_colors.dart';
import 'package:attendance_management_app/shared/utilities/size_utils.dart';
import 'package:attendance_management_app/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ClassTab extends StatelessWidget {
  const ClassTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              visible: true,
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
                    title: "You haven’t created any class for this course yet.",
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
                    return const ClassCard();
                  },
                  separatorBuilder: (ctx, idx) => verticalSpace(8),
                  itemCount: 2)),
        ],
      ),
    );
  }
}
