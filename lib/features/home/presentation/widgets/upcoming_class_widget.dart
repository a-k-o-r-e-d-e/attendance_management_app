import 'package:attendance_management_app/shared/utilities/app_colors.dart';
import 'package:attendance_management_app/shared/utilities/size_utils.dart';
import 'package:attendance_management_app/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import '../../domain/model/upcoming_class_model.dart';

class UpcomingClassWidget extends StatelessWidget {
  final UpcomingClassModel model;

  const UpcomingClassWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightSizer(281, context),
      width: widthSizer(258, context),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.appLight30),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 184,
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4), topLeft: Radius.circular(4))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomText(
              title: model.courseTitle,
              size: widthSizer(16, context),
              weight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Divider(
            height: 0,
            color: AppColors.appLight40,
          ),
          /*  Row(
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
          )*/
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time_filled_rounded,
                      color: AppColors.medium200,
                    ),
                    CustomText(
                      title: "08 - 10AM",
                      size: 14,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: AppColors.medium200,
                    ),
                    CustomText(
                      title: "15/02",
                      size: 14,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.medium200,
                    ),
                    CustomText(
                      title: "Online",
                      size: 14,
                      weight: FontWeight.w500,
                    )
                  ],
                ),
              ],
            ),
          ),
          verticalSpace(8)
        ],
      ),
    );
  }
}
