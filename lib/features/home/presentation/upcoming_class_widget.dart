import 'package:attendance_management_app/shared/utilities/app_colors.dart';
import 'package:attendance_management_app/shared/utilities/size_utils.dart';
import 'package:attendance_management_app/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import '../domain/model/upcoming_class_model.dart';
import 'package:intl/intl.dart';

class UpcomingClassWidget extends StatelessWidget {
  final UpcomingClassModel model;

  const UpcomingClassWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: heightSizer(318, context),
      width: widthSizer(258, context),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.appLight30),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(4)),
          ),
          CustomText(
            title: model.courseTitle,
            size: widthSizer(16, context),
            weight: FontWeight.w500,
            overflow: TextOverflow.clip,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                title: "Student enrolled",
                size: widthSizer(16, context),
                weight: FontWeight.w500,
                color: AppColors.medium300,
              ),
              CustomText(
                title: "${model.studentEnrolled} Students",
                size: widthSizer(16, context),
                weight: FontWeight.w500,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                title: "Date",
                size: widthSizer(16, context),
                weight: FontWeight.w500,
                color: AppColors.medium300,
              ),
              CustomText(
                title: DateFormat("d/M/y").format(model.startDate!),
                size: widthSizer(16, context),
                weight: FontWeight.w500,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                title: "Time",
                size: widthSizer(16, context),
                weight: FontWeight.w500,
                color: AppColors.medium300,
              ),
              CustomText(
                title: DateFormat.jm().format(model.startDate!),
                size: widthSizer(16, context),
                weight: FontWeight.w500,
              ),
            ],
          )
        ],
      ),
    );
  }
}
