import 'package:attendance_management_app/features/authentication/presentation/providers/create_user_state_provider.dart';
import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../providers/states/user_type_state.dart';
import '../widgets/select_user_tile.dart';

@RoutePage()
class SelectUserTypeScreen extends ConsumerWidget {
  const SelectUserTypeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserType userType = ref.watch(createAccountUserTypeProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(
              color: AppColors.appLight50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  verticalSpace(24),
                  GeneralButton(
                    buttonText: "Next",
                    onPressed: () {
                      userType == UserType.none
                          ? null
                          : context.router.navigateNamed("/create-account");
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
                        title: "Already have an account?",
                        weight: FontWeight.w400,
                        size: 16,
                      ),
                      horizontalSpace(16),
                      GestureDetector(
                        onTap: (){
                          context.router.navigateNamed("/login");
                        },
                        child: const CustomText(
                          title: "Login",
                          weight: FontWeight.w600,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(heightSizer(56, context)),
                ],
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.center,
                child: CustomText(
                  title: "Select User Type",
                  weight: FontWeight.w500,
                  size: 24,
                ),
              ),
              verticalSpace(48),
              SelectUserTile(
                userType: UserType.lecturer,
                onPressed: () {
                  ref
                      .read(createAccountUserTypeProvider.notifier)
                      .setUserType(UserType.lecturer);
                },
                selected: userType == UserType.lecturer,
              ),
              verticalSpace(24),
              SelectUserTile(
                userType: UserType.student,
                selected: userType == UserType.student,
                onPressed: () {
                  ref
                      .read(createAccountUserTypeProvider.notifier)
                      .setUserType(UserType.student);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
