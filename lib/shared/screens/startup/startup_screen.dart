import 'dart:developer';

import 'package:attendance_management_app/features/authentication/domain/models/user_model.dart';
import 'package:attendance_management_app/features/authentication/domain/providers/auth_repo_provider.dart';
import 'package:attendance_management_app/features/authentication/domain/repository/auth_repo.dart';
import 'package:attendance_management_app/shared/providers/app_user_provider.dart';
import 'package:attendance_management_app/shared/routes/app_route.dart';
import 'package:attendance_management_app/shared/services/saved_info_service/domain/repository/saved_info_repo.dart';
import 'package:attendance_management_app/shared/services/saved_info_service/providers/saved_info_provider.dart';
import 'package:attendance_management_app/shared/utilities/app_strings.dart';
import 'package:attendance_management_app/shared/utilities/size_utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../utilities/app_colors.dart';

@RoutePage()
class StartupScreen extends ConsumerStatefulWidget {
  const StartupScreen({super.key});

  @override
  ConsumerState<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends ConsumerState<StartupScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      requiredSetup();
    });
    //_navigationService.replaceWithSignupView();
  }

  Future<void> requiredSetup() async {
    final SavedInfoService savedInfo =
        ref.read(savedInfoServiceMethodsProvider);
    final AuthenticationRepository auth = ref.read(authRepoProvider);
    Map<String, dynamic>? user = await savedInfo
        .getInfo(AppStrings.USER_JSON_KEY) as Map<String, dynamic>?;
    log(user.toString());
    if (user == null) {
      bool? firstRun =
          await savedInfo.getInfo(AppStrings.APP_FIRST_RUN_KEY) as bool?;
      if (firstRun == null || firstRun) {
        await savedInfo.saveInfo(AppStrings.APP_FIRST_RUN_KEY, false);
        if (!mounted) return;
        context.replaceRoute(OnboardingRoute());
      } else {
        if (!mounted) return;
        context.replaceRoute(LoginRoute());
      }
    } else {
      String? token =
          await savedInfo.getInfo(AppStrings.AUTH_TOKEN_KEY) as String?;
      log(token.toString());
      ref
          .read(appUserProvider.notifier)
          .setUserType(UserAccount.fromJson(user));
      if (!mounted) return;
      if (token == null) {
        context.replaceRoute(LoginRoute());
      } else {
        try {
          await auth.authenticate();
          log("token refreshed");
          if (!mounted) return;
          context.router.replaceAll([const HomeRoute()]);
        } catch (e) {
          log(e.toString());
          context.replaceRoute(LoginRoute());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: screenHeight(context),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingIndicator(
                indicatorType: Indicator.ballClipRotatePulse,
                colors: [
                  AppColors.primary500,
                  AppColors.appOrange,
                ],
                strokeWidth: 2,
                backgroundColor: Colors.transparent,
                pathBackgroundColor: Colors.transparent),
            verticalSpaceLarge,
            CustomText(
              title: "ATTENDANCE MANAGEMENT APP",
            )
          ],
        ),
      ),
    );
  }
}
