import 'package:attendance_management_app/shared/widgets/custom_text_form_field.dart';
import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';

@RoutePage()
class CreateAccountScreen extends ConsumerWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //UserType userType = ref.watch(createAccountUserTypeProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Create Lecturer account',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(24),
              const CustomText(
                title: "Title",
              ),
              verticalSpace(8),
              const CustomTextFormField(
                hintText: "John Doe",
              ),
              verticalSpace(18),
              const CustomText(
                title: "Full Name",
              ),
              verticalSpace(8),
              const CustomTextFormField(
                hintText: "John Doe",
              ),
              verticalSpace(18),
              const CustomText(
                title: "Gender",
              ),
              verticalSpace(8),
              const CustomTextFormField(
                hintText: "John Doe",
              ),
              verticalSpace(18),
              const CustomText(
                title: "Title",
              ),
              verticalSpace(8),
              const CustomTextFormField(
                hintText: "John Doe",
              ),
              verticalSpace(18),
              const CustomText(
                title: "Email",
              ),
              verticalSpace(8),
              const CustomTextFormField(
                hintText: "John Doe",
              ),
              verticalSpace(18),
              const CustomText(
                title: "Phone Number",
              ),
              verticalSpace(8),
              const CustomTextFormField(
                hintText: "John Doe",
              ),
              verticalSpace(18),
              const CustomText(
                title: "Username",
              ),
              verticalSpace(8),
              const CustomTextFormField(
                hintText: "John Doe",
              ),
              verticalSpace(18),
              const CustomText(
                title: "Username (for the online system)",
              ),
              verticalSpace(8),
              const CustomTextFormField(
                hintText: "John Doe",
              ),
              verticalSpace(18),
              const CustomText(
                title: "Institution/Organization",
              ),
              verticalSpace(8),
              const CustomTextFormField(
                hintText: "John Doe",
              ),
              verticalSpace(18),
              const CustomText(
                title: "Department",
              ),
              verticalSpace(8),
              const CustomTextFormField(
                hintText: "John Doe",
              ),
              verticalSpace(18),
              const CustomText(
                title: "Current Position",
              ),
              verticalSpace(8),
              const CustomTextFormField(
                hintText: "John Doe",
              ),
              verticalSpace(18),
              const CustomText(
                title: "Institution/Organization",
              ),
              verticalSpace(8),
              const CustomTextFormField(
                hintText: "John Doe",
              ),
              verticalSpace(18),
              const CustomText(
                title: "Employee ID or Staff ID",
              ),
              verticalSpace(8),
              const CustomTextFormField(
                hintText: "John Doe",
              ),
              verticalSpace(18),
              const CustomText(
                title: "Academic Affiliation or Institution",
              ),
              verticalSpace(8),
              const CustomTextFormField(
                hintText: "John Doe",
              ),
              verticalSpace(18),
              const CustomText(
                title: "Password (for account access)",
              ),
              verticalSpace(8),
              const CustomTextFormField(
                hintText: "John Doe",
              ),

              verticalSpace(32),

              GeneralButton(
                buttonText: "Create account",
                onPressed: () {
                 /* userType == UserType.none
                      ? null
                      : context.router.navigateNamed("/create-account");*/
                },
                height: 48,
              ),
              verticalSpace(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    title: "Already have an account?",
                    weight: FontWeight.w400,
                    size: 16,
                    color: AppColors.medium300,
                  ),
                  horizontalSpace(16),
                  GestureDetector(
                    onTap: (){
                      context.router.replaceNamed("/login");
                    },
                    child: const CustomText(
                      title: "Login",
                      weight: FontWeight.w600,
                      size: 16,
                    ),
                  ),
                ],
              ),
              verticalSpace(heightSizer(24, context)),
            ],
          ),
        ),
      ),
    );
  }
}
