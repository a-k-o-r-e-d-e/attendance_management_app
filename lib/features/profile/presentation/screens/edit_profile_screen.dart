import 'package:attendance_management_app/features/home/domain/model/upcoming_class_model.dart';
import 'package:attendance_management_app/features/home/presentation/providers/upcoming_class_provider.dart';
import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../../../shared/widgets/custom_text_form_field.dart';

@RoutePage()
class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<UpcomingClassModel>> activity =
        ref.watch(upcomingClassProvider);
    return Scaffold(
      appBar: CustomAppBar(
        prefixIcon: GestureDetector(
            onTap: () {
              context.back();
            },
            child: const Icon(Icons.keyboard_arrow_left_rounded)),
        centerTitle: true,
        title: 'Profile Information',
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
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 100,
                    child: Stack(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                                color: AppColors.primary500,
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              "assets/svgs/add-img.svg",
                              width: 24,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpace(40),
                const CustomText(
                  title: "Title",
                  size: 14,
                  weight: FontWeight.w400,
                ),
                verticalSpace(8),
                const CustomTextFormField(
                  hintText: "Dr",
                  suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                ),
                verticalSpace(24),
                const CustomText(
                  title: "Name",
                  size: 14,
                  weight: FontWeight.w400,
                ),
                verticalSpace(8),
                const CustomTextFormField(
                  fillColor: AppColors.appLight30,
                  readOnly: true,
                  hintText: "Awosanya Adeagbo",
                ),
                verticalSpace(24),
                const CustomText(
                  title: "Email",
                  size: 14,
                  weight: FontWeight.w400,
                ),
                verticalSpace(8),
                const CustomTextFormField(
                  initialValue: "ade.awosanya@ui.edu.ng",
                  suffixIcon: Icon(
                    Icons.border_color_outlined,
                    color: Color(0xFFB3B6CB),
                    size: 20,
                  ),
                ),
                verticalSpace(24),
                const CustomText(
                  title: "Phone number",
                  size: 14,
                  weight: FontWeight.w400,
                ),
                verticalSpace(8),
                const CustomTextFormField(
                  initialValue: "08123456789",
                  suffixIcon: Icon(
                    Icons.border_color_outlined,
                    color: Color(0xFFB3B6CB),
                    size: 20,
                  ),
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
