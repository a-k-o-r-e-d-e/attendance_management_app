import 'package:flutter/material.dart';

import '../utilities/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final Color? fillColor;
  final double? borderSize;
  final int? maxLine;
  final InputBorder? border;
  final bool? obscureText;
  final bool? readOnly;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const CustomTextFormField(
      {super.key,
      this.hintText,
      this.suffixIcon,
      this.fillColor,
      this.controller,
      this.validator,
      this.keyboardType,
      this.border,
      this.obscureText,
      this.borderSize,
      this.maxLine, this.readOnly});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine ?? 1,
      keyboardType: keyboardType,
      controller: controller,
      readOnly: readOnly?? false,
      validator: validator,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 5),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor ?? Colors.white,
        hintText: hintText ?? '',
        hintStyle: const TextStyle(
            color: AppColors.placeHolder,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        border: border ??
            OutlineInputBorder(
              borderSide: BorderSide(
                  width: borderSize ?? 1, color: AppColors.medium200),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: borderSize ?? 1, color: Colors.red),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.medium200,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.primary500,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
