import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../utilities/app_colors.dart';
import 'custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double? verticalPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function()? onPressed;

  const CustomAppBar(
      {super.key,
      required this.title,
      this.suffixIcon,
      this.onPressed,
      this.prefixIcon,
      this.verticalPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 0, vertical: verticalPadding ?? 0),
      child: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: CustomText(
          title: title,
          size: 20,
          weight: FontWeight.w500,
          color: AppColors.textBlack,
        ),
        leading: prefixIcon ??
            InkWell(
                onTap: onPressed ??
                    () {
                      context.router.back();
                    },
                child: const Icon(Icons.arrow_back_ios_new)),
        actions: [suffixIcon ?? const SizedBox()],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
