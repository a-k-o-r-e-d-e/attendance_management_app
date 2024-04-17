import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../../../shared/widgets/custom_text_form_field.dart';

@RoutePage()
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: CustomAppBar(
        prefixIcon: GestureDetector(
            onTap: () {
              context.back();
            },
            child: const Icon(Icons.keyboard_arrow_left_rounded)),
        centerTitle: true,
        title: 'Settings',
        showBorder: true,
      ),
      backgroundColor: Colors.white,
      body: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(24),
                const CustomText(
                  title: "Change Password",
                  size: 16,
                  weight: FontWeight.w500,
                ),
                verticalSpace(16),
                const CustomText(
                  title: "Old Password",
                  size: 14,
                  weight: FontWeight.w400,
                ),
                verticalSpace(8),
                const CustomTextFormField(
                  hintText: "******",
                ),
                verticalSpace(24),
                const CustomText(
                  title: "New Password",
                  size: 14,
                  weight: FontWeight.w400,
                ),
                verticalSpace(8),
                const CustomTextFormField(
                  hintText: "******",
                ),
                verticalSpace(24),
                const CustomText(
                  title: "Confirm Password",
                  size: 14,
                  weight: FontWeight.w400,
                ),
                verticalSpace(8),
                const CustomTextFormField(
                  hintText: "******",
                ),
                verticalSpace(24),
                GeneralButton(buttonText: "Save changes", onPressed: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
