import 'package:attendance_management_app/shared/routes/app_route.dart';
import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../../../shared/widgets/custom_text_form_field.dart';
import '../providers/login_user_state_provider.dart';
import '../providers/states/user_type_state.dart';
import '../widgets/select_login_user_tile.dart';

@RoutePage()
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserType userType = ref.watch(loginUserTypeProvider);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Log In',
          prefixIcon: InkWell(
              onTap: () {
                context.router.back();
              },
              child: const Icon(Icons.arrow_back_ios_new)),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                verticalSpace(heightSizer(56, context)),
                const Align(
                  alignment: Alignment.center,
                  child: CustomText(
                    title: "Log into your account",
                    weight: FontWeight.w500,
                    size: 20,
                  ),
                ),
                verticalSpace(48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SelectLoginUserTile(
                      userType: UserType.lecturer,
                      onPressed: () {
                        ref
                            .read(loginUserTypeProvider.notifier)
                            .setUserType(UserType.lecturer);
                      },
                      selected: userType == UserType.lecturer,
                    ),
                    horizontalSpace(20),
                    SelectLoginUserTile(
                      userType: UserType.student,
                      selected: userType == UserType.student,
                      onPressed: () {
                        ref
                            .read(loginUserTypeProvider.notifier)
                            .setUserType(UserType.student);
                      },
                    ),
                  ],
                ),
                verticalSpace(24),
                const CustomText(
                  title: "Email or username",
                ),
                verticalSpace(8),
                const CustomTextFormField(
                  hintText: "john@email.com",
                ),
                verticalSpace(18),
                const CustomText(
                  title: "Password",
                ),
                verticalSpace(8),
                const CustomTextFormField(
                  hintText: "******",
                ),
                verticalSpace(32),
                GeneralButton(
                  buttonText: "Sign In",
                  onPressed: () {
                    userType == UserType.none
                        ? null
                        : context.router.replaceAll([const HomeRoute()]);
                  },
                  buttonColor:
                      userType == UserType.none ? AppColors.appLight50 : null,
                  height: 48,
                ),
                verticalSpace(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      title: "Don't have an account?",
                      weight: FontWeight.w400,
                      size: 16,
                      color: AppColors.medium300,
                    ),
                    horizontalSpace(16),
                    GestureDetector(
                      onTap: () {
                        context.router.replaceNamed("/create-account");
                      },
                      child: const CustomText(
                        title: "Create account",
                        weight: FontWeight.w600,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
