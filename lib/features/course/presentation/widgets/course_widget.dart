import 'package:attendance_management_app/shared/utilities/app_colors.dart';
import 'package:attendance_management_app/shared/utilities/size_utils.dart';
import 'package:attendance_management_app/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../domain/models/course_model.dart';

class CourseWidget extends StatelessWidget {
  final Course model;

  const CourseWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(4)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
            child: CustomText(
              title: model.title,
              size: widthSizer(16, context),
              weight: FontWeight.w500,
              overflow: TextOverflow.clip,
            ),
          ),
          const Divider(
            color: AppColors.appLight40,
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/svgs/class_card.svg"),
                CustomText(
                  title: " 0 Classes has been added to this course",
                  size: widthSizer(14, context),
                  weight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
