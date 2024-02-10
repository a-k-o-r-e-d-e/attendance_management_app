import 'package:flutter/material.dart';
import '../utilities/app_colors.dart';
import 'custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double? verticalPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? centerTitle;
  final bool showBorder;
  final bool? automaticallyImplyLeading;
  final void Function()? onPressed;

  const CustomAppBar(
      {super.key,
      required this.title,
      this.suffixIcon,
      this.onPressed,
      this.prefixIcon,
      this.verticalPadding,
      this.centerTitle,
      this.automaticallyImplyLeading,
      this.showBorder = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 0, vertical: verticalPadding ?? 0),
      child: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: centerTitle ?? true,
        automaticallyImplyLeading: automaticallyImplyLeading ?? false,
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: showBorder
            ? PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                  color: AppColors.appLight30,
                  height: 1.0,
                ),
              )
            : null,
        title: CustomText(
          title: title,
          size: 20,
          weight: FontWeight.w500,
        ),
        leading: prefixIcon,
        actions: [suffixIcon ?? const SizedBox()],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
