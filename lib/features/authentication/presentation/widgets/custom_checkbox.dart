import 'package:attendance_management_app/shared/utilities/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool isChecked;
  final Color? checkedColor;
  final double size;
  final ValueChanged<bool?>? onTap;

  const CustomCheckBox({
    super.key,
    required this.isChecked,
    required this.size,
    this.onTap,
    this.checkedColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!(!isChecked);
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(
            color: isChecked ? checkedColor! : AppColors.appDark700,
            width: 2,
          ),
        ),
        child: isChecked
            ? Icon(
                Icons.check,
                color: checkedColor,
                size: size * 0.7,
              )
            : null,
      ),
    );
  }
}
