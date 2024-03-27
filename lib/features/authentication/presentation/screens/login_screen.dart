import 'package:attendance_management_app/features/authentication/domain/models/user_model.dart';
import 'package:attendance_management_app/shared/utilities/validator.dart';
import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/app_user_provider.dart';
import '../../../../shared/routes/app_route.dart';
import '../../../../shared/services/dio_service/domain/models/api_response_model.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/utilities/toast_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../../../shared/widgets/custom_text_form_field.dart';
import '../../../../shared/widgets/dialogs/loading_dialog.dart';
import '../../domain/providers/auth_repo_provider.dart';
import '../../domain/repository/auth_repo.dart';
import '../providers/login_user_state_provider.dart';
import '../providers/states/user_type_state.dart';
import '../widgets/select_login_user_tile.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    UserType userType = ref.watch(loginUserTypeProvider);
    Future signIn() async {
      Map<String, dynamic> data = {
        "emailOrUsername": widget.emailController.text,
        "password": widget.passwordController.text,
        "user_type": userType == UserType.student ? "student" : "lecturer"
      };

      print(data);
      AuthenticationRepository authService = ref.watch(authRepoProvider);
      try {
        LoadingDialog.show(context);
        UserAccount user = await authService.login(data);
        ref.read(appUserProvider.notifier).setUserType(user);
        if (!mounted) return;
        context.router.pop();

        ToastService.success(context, "login successful", seconds: 3);
        context.router.replaceAll([const HomeRoute()]);
      } on ErrorResponse catch (exception, _) {
        context.router.pop();

        print(exception.exception);
        ToastService.error(context, exception.exception.error.toString());
      }
    }

    return Scaffold(
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
          child: Form(
            key: widget.formKey,
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
                CustomTextFormField(
                  hintText: "john@email.com",
                  controller: widget.emailController,
                  validator: (val) => Validator.validateName(val),
                ),
                verticalSpace(18),
                const CustomText(
                  title: "Password",
                ),
                verticalSpace(8),
                CustomTextFormField(
                  hintText: "******",
                  controller: widget.passwordController,
                  obscureText: true,
                  validator: (val) => Validator.validatePassword(val),
                ),
                verticalSpace(32),
                GeneralButton(
                  buttonText: "Sign In",
                  onPressed: () {
                    if (userType == UserType.none) {
                    } else {
                      if (widget.formKey.currentState!.validate()) {
                        widget.formKey.currentState!.save();
                        // Do something with the validated and saved values

                        signIn();
                      }
                    }
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
                        context.router.replaceNamed("/select-user-type");
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
