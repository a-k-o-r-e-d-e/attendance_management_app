import 'package:attendance_management_app/features/authentication/presentation/providers/states/user_type_state.dart';
import 'package:attendance_management_app/features/class/presentation/providers/get_classes_provider.dart';
import 'package:attendance_management_app/shared/routes/app_route.dart';
import 'package:attendance_management_app/shared/widgets/custom_bottom_navbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../shared/providers/app_user_provider.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../../home/presentation/widgets/upcoming_class_widget.dart';
import '../../domain/models/upcoming_class_model.dart';
import '../widgets/class_schedule_modal.dart';

@RoutePage()
class ClassScreen extends ConsumerWidget {
  const ClassScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String appUser = ref.read(appUserProvider).profile!.user!.roles![0];

    Future<void> refresh() async {
      ref.invalidate(getClassesProvider(
          appUser == 'lecturer' ? UserType.lecturer : UserType.student));
    }

    final AsyncValue<List<UpcomingClassModel>> fetchClasses = ref.watch(
        getClassesProvider(
            appUser == 'lecturer' ? UserType.lecturer : UserType.student));
    return Scaffold(
      appBar: CustomAppBar(
        prefixIcon: null,
        centerTitle: false,
        title: 'Class',
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: SvgPicture.asset("assets/svgs/notif.svg"),
        ),
        showBorder: true,
      ),
      backgroundColor: Colors.white,
      body: CustomBottomNavBar(
        parent: NavIdentifier.classNav,
        child: Scaffold(
          backgroundColor: Colors.white,
          /*
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 16.0, left: 20, right: 20),
            child: GeneralButton(
              buttonText: 'Create new class',
              onPressed: () {
                context.router.navigateNamed("/create-class");
              },
            ),
          ),
    */
          body: RefreshIndicator(
            onRefresh: refresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    verticalSpace(24),
                    switch (fetchClasses) {
                      AsyncData(:final value) => Visibility(
                          visible: value.isNotEmpty,
                          replacement: Align(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                verticalSpace(heightSizer(165, context)),
                                SvgPicture.asset("assets/svgs/info.svg"),
                                verticalSpace(32),
                                const CustomText(
                                  title: "You don't have any upcoming class",
                                  size: 24,
                                  weight: FontWeight.w400,
                                  textAlign: TextAlign.center,
                                  color: AppColors.medium200,
                                  overflow: TextOverflow.clip,
                                )
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                    title: "Upcoming Class",
                                    weight: FontWeight.w500,
                                    size: 20,
                                    color: AppColors.appDark700,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      ClassScheduleBottomSheet.show(
                                          context, ref);
                                    },
                                    child: Ink(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              color: AppColors.appLight30)),
                                      child: SvgPicture.asset(
                                          "assets/svgs/calendar.svg"),
                                    ),
                                  )
                                ],
                              ),
                              verticalSpace(16),
                              ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        context.pushRoute(SingleClassRoute(
                                            classInstance: value[index].base!,
                                            classID: value[index].id!));
                                      },
                                      child: Stack(children: [
                                        UpcomingClassWidget(
                                          model: value[index].base!,
                                        ),
                                        Visibility(
                                          visible:
                                              value[index].status == "ongoing",
                                          child: Positioned(
                                            right: 8,
                                            top: 8,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                  color: AppColors.appGreen,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: const CustomText(
                                                title: "Ongoing",
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      ]),
                                    );
                                  },
                                  separatorBuilder: (ctx, idx) =>
                                      verticalSpace(24),
                                  itemCount: value.length),
                            ],
                          ),
                        ),
                      AsyncError() =>
                        const Text('Oops, something unexpected happened'),
                      _ => Shimmer(
                          period: const Duration(seconds: 2),
                          //Default value
                          loop: 1,
                          enabled: true,
                          //Default value
                          direction: ShimmerDirection.ltr,
                          gradient: LinearGradient(colors: [
                            Colors.white,
                            Colors.grey.withOpacity(.5)
                          ]),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.appGrey,
                                borderRadius: BorderRadius.circular(8)),
                            width: double.infinity,
                            height: heightSizer(318, context),
                          ),
                        ),
                    },
                    verticalSpace(24)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
