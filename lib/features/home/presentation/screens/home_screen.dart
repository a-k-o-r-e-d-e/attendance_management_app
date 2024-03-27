import 'package:attendance_management_app/features/home/domain/model/upcoming_class_model.dart';
import 'package:attendance_management_app/features/home/presentation/providers/upcoming_class_provider.dart';
import 'package:attendance_management_app/shared/providers/app_user_provider.dart';
import 'package:attendance_management_app/shared/widgets/custom_bottom_navbar.dart';
import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../../authentication/domain/models/user_model.dart';
import '../widgets/upcoming_class_widget.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<UpcomingClassModel>> activity =
        ref.watch(upcomingClassProvider);
    final UserAccount appUser = ref.watch(appUserProvider);
    return Scaffold(
      appBar: CustomAppBar(
        prefixIcon: null,
        centerTitle: false,
        title: 'Home',
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: SvgPicture.asset("assets/svgs/notif.svg"),
        ),
        showBorder: true,
      ),
      backgroundColor: Colors.white,
      body: CustomBottomNavBar(
        parent: NavIdentifier.home,
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: appUser.profile?.user?.roles![0] == "lecturer"
              ? Padding(
                  padding:
                      const EdgeInsets.only(bottom: 16.0, left: 20, right: 20),
                  child: GeneralButton(
                    buttonText: 'Create a course',
                    onPressed: () {
                      context.router.navigateNamed("/create-course");
                    },
                  ),
                )
              : null,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  /*verticalSpace(24),
                  SizedBox(
                    height: 44,
                    child: CustomTextFormField(
                      border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFFD5D7DB)),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      hintText: "Search for Classes",
                      suffixIcon: SvgPicture.asset(
                        "assets/svgs/search.svg",
                        width: 20,
                        height: 20,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),*/
                  verticalSpace(24),
                  activity.when(data: (List<UpcomingClassModel> data) {
                    return Visibility(
                      visible: data.isNotEmpty,
                      replacement: Column(
                        children: [
                          verticalSpace(heightSizer(165, context)),
                          SvgPicture.asset("assets/svgs/info.svg"),
                          verticalSpace(32),
                          const CustomText(
                            title: "You haven’t created any courses yet.",
                            size: 24,
                            weight: FontWeight.w400,
                            textAlign: TextAlign.center,
                            color: AppColors.medium200,
                            overflow: TextOverflow.clip,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomText(
                                title: "Upcoming Class",
                                weight: FontWeight.w500,
                                size: 20,
                                color: AppColors.appDark700,
                              ),
                              Row(
                                children: [
                                  const CustomText(
                                    title: "See all",
                                    weight: FontWeight.w500,
                                    size: 16,
                                    color: AppColors.appDark700,
                                  ),
                                  horizontalSpace(4),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 12,
                                  ),
                                ],
                              )
                            ],
                          ),
                          verticalSpace(16),
                          SizedBox(
                            height: 280,
                            child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    UpcomingClassWidget(
                                      model: data[0],
                                    ),
                                separatorBuilder: (ctx, idx) =>
                                    horizontalSpace(24),
                                itemCount: 2),
                          ),
                        ],
                      ),
                    );
                  }, error: (Object error, StackTrace stackTrace) {
                    print(stackTrace);
                    return Text(stackTrace.toString());
                  }, loading: () {
                    return Shimmer(
                      period: const Duration(seconds: 2),
                      //Default value
                      loop: 1,
                      enabled: true,
                      //Default value
                      direction: ShimmerDirection.ltr,
                      gradient: LinearGradient(
                          colors: [Colors.white, Colors.grey.withOpacity(.5)]),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.appGrey,
                            borderRadius: BorderRadius.circular(8)),
                        width: double.infinity,
                        height: heightSizer(318, context),
                      ),
                    );
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
