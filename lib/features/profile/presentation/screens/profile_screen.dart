import 'package:attendance_management_app/shared/models/user_model.dart';
import 'package:attendance_management_app/features/profile/presentation/widgets/logout_modal.dart';
import 'package:attendance_management_app/shared/routes/app_route.dart';
import 'package:attendance_management_app/shared/widgets/custom_bottom_navbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/app_user_provider.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';

@RoutePage()
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserAccount user = ref.watch(appUserProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        prefixIcon: null,
        centerTitle: false,
        title: 'Profile',
        showBorder: false,
      ),
      backgroundColor: Colors.white,
      body: CustomBottomNavBar(
        parent: NavIdentifier.profile,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 24),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 36,
                        ),
                      ),
                      verticalSpace(20),
                      CustomText(
                        title:
                            "${user.profile?.title}. ${user.profile?.lastName} ${user.profile?.firstName}",
                        size: 24,
                        weight: FontWeight.w500,
                      ),
                      verticalSpace(8),
                      CustomText(
                        title: "${user.profile?.user!.roles![0]}",
                        size: 14,
                        weight: FontWeight.w500,
                        color: AppColors.medium300,
                      ),
                      verticalSpace(32),
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.appLight30,
                ),
                verticalSpace(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () {
                          context.navigateTo(EditProfileRoute(user: user));
                        },
                        leading: const Icon(
                          Icons.person,
                          size: 20,
                          color: Color(0xFF616B7C),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: 20,
                          color: Color(0xFF616B7C),
                        ),
                        title: const CustomText(
                          title: "Profile information",
                          size: 16,
                          weight: FontWeight.w400,
                        ),
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Color(0xFFD5D7DB)),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      verticalSpace(24),
                      ListTile(
                        onTap: () {
                          context.navigateNamedTo("/settings");
                        },
                        leading: const Icon(
                          Icons.settings,
                          size: 20,
                          color: Color(0xFF616B7C),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: 20,
                          color: Color(0xFF616B7C),
                        ),
                        title: const CustomText(
                          title: "Settings",
                          size: 16,
                          weight: FontWeight.w400,
                        ),
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Color(0xFFD5D7DB)),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      verticalSpace(24),
                      ListTile(
                        onTap: () {
                          LogoutModal.show(context, ref);
                        },
                        leading: const Icon(
                          Icons.logout_rounded,
                          size: 20,
                          color: Color(0xFF616B7C),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: 20,
                          color: Color(0xFF616B7C),
                        ),
                        title: const CustomText(
                          title: "Log out",
                          size: 16,
                          weight: FontWeight.w400,
                        ),
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Color(0xFFD5D7DB)),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
