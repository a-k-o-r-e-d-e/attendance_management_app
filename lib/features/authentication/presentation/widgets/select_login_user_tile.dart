import "package:attendance_management_app/shared/utilities/app_colors.dart";
import "package:flutter/material.dart";
import "../../../../shared/utilities/size_utils.dart";
import "../../../../shared/widgets/custom_text.dart";
import "../providers/states/user_type_state.dart";
import "custom_checkbox.dart";

class SelectLoginUserTile extends StatelessWidget {
  final UserType userType;
  final bool selected;
  final void Function() onPressed;

  const SelectLoginUserTile({
    super.key,
    required this.userType,
    required this.onPressed,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: selected ? AppColors.primary500 : AppColors.appLight50)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 36,
              child: Image.asset(userType == UserType.lecturer
                  ? "assets/images/lecturer_avatar.png"
                  : "assets/images/student_avatar.png"),
            ),
            verticalSpace(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  title: userType == UserType.lecturer ? "Lecturer" : "Student",
                  weight: FontWeight.w500,
                  size: 24,
                ),
                horizontalSpace(28),
                CustomCheckBox(
                  onTap: null,
                  isChecked: selected,
                  checkedColor: AppColors.primary500,
                  size: 24,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
