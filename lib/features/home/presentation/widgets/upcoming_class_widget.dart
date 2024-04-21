import 'package:attendance_management_app/shared/utilities/app_colors.dart';
import 'package:attendance_management_app/shared/utilities/size_utils.dart';
import 'package:attendance_management_app/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../shared/models/base_model.dart';
import '../../../../shared/utilities/string_utils.dart';

class UpcomingClassWidget extends StatelessWidget {
  final Base model;

  const UpcomingClassWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                image: DecorationImage(
                    image: AssetImage("assets/images/cover-photo-3.jpeg"),
                    fit: BoxFit.cover),
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4), topLeft: Radius.circular(4))),
          ),
          verticalSpace(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomText(
              title: model.title,
              size: widthSizer(16, context),
              weight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          verticalSpace(8),
          const Divider(
            height: 0,
            color: AppColors.appLight40,
          ),
          verticalSpace(8),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_filled_rounded,
                      color: AppColors.medium200,
                    ),
                    CustomText(
                      title:
                          "${StringUtils.formatTime(model.startTime.toString())} - ${StringUtils.formatTime(model.endTime.toString())}",
                      size: 14,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: AppColors.medium200,
                    ),
                    CustomText(
                      title: DateFormat('dd/MM').format(model.startDate!),
                      size: 14,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColors.medium200,
                    ),
                    CustomText(
                      title: model.mode,
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
