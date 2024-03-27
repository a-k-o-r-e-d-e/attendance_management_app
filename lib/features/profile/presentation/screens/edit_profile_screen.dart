import 'package:attendance_management_app/features/authentication/domain/models/user_model.dart';
import 'package:attendance_management_app/features/profile/domain/providers/profile_repo_provider.dart';
import 'package:attendance_management_app/shared/utilities/validator.dart';
import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../shared/services/dio_service/domain/models/api_response_model.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/utilities/toast_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../../../shared/widgets/custom_text_form_field.dart';
import '../../../../shared/widgets/dialogs/loading_dialog.dart';
import '../../../authentication/presentation/providers/states/user_type_state.dart';
import '../../domain/repository/profile_repo.dart';

@RoutePage()
class EditProfileScreen extends ConsumerStatefulWidget {
  final UserAccount user;

  EditProfileScreen(this.user, {super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  @override
  void initState() {
    setState(() {
      widget.emailController.text = widget.user.profile!.user!.email!;
      widget.phoneController.text = widget.user.profile!.phoneNumber!;
      widget.titleController.text = widget.user.profile!.title!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future update() async {
      Map<String, dynamic> data = {
        "title": widget.titleController.text,
        "phone_number": widget.phoneController.text,
        "user": {"email": widget.emailController.text}
      };

      print(data);
      ProfileRepository profileService = ref.watch(profileRepoProvider);
      try {
        LoadingDialog.show(context);
        var response = await profileService.updateProfile(
            widget.user.profile!.user!.roles![0] == "student"
                ? UserType.student
                : UserType.lecturer,
            data);

        if (!mounted) return;
        context.router.pop();

        ToastService.success(context, "change successful", seconds: 2);
      } on ErrorResponse catch (exception, _) {
        context.router.pop();

        print(exception.exception);
        ToastService.error(context, exception.exception.error.toString());
      }
    }

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
            child: Form(
              key: widget.formKey,
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
                  CustomTextFormField(
                    controller: widget.titleController,
                    validator: (val) => Validator.validateMaxiMin(val, 2, 10),
                    //suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                  ),
                  verticalSpace(24),
                  const CustomText(
                    title: "Name",
                    size: 14,
                    weight: FontWeight.w400,
                  ),
                  verticalSpace(8),
                  CustomTextFormField(
                    fillColor: AppColors.appLight30,
                    readOnly: true,
                    hintText:
                        "${widget.user.profile?.lastName} ${widget.user.profile?.firstName}",
                  ),
                  verticalSpace(24),
                  const CustomText(
                    title: "Email",
                    size: 14,
                    weight: FontWeight.w400,
                  ),
                  verticalSpace(8),
                  CustomTextFormField(
                    suffixIcon: const Icon(
                      Icons.border_color_outlined,
                      color: Color(0xFFB3B6CB),
                      size: 20,
                    ),
                    controller: widget.emailController,
                    validator: (val) => Validator.validateEmail(val),
                  ),
                  verticalSpace(24),
                  const CustomText(
                    title: "Phone number",
                    size: 14,
                    weight: FontWeight.w400,
                  ),
                  verticalSpace(8),
                  CustomTextFormField(
                    suffixIcon: const Icon(
                      Icons.border_color_outlined,
                      color: Color(0xFFB3B6CB),
                      size: 20,
                    ),
                    controller: widget.phoneController,
                    validator: (val) => Validator.validatePhoneNumber(val),
                  ),
                  verticalSpace(24),
                  GeneralButton(
                      buttonText: "Save changes",
                      onPressed: () {
                        if (widget.formKey.currentState!.validate()) {
                          widget.formKey.currentState!.save();
                          // Do something with the validated and saved values

                          update();
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
