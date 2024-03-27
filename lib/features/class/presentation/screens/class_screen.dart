import 'package:attendance_management_app/features/home/domain/model/upcoming_class_model.dart';
import 'package:attendance_management_app/features/home/presentation/providers/upcoming_class_provider.dart';
import 'package:attendance_management_app/shared/routes/app_route.dart';
import 'package:attendance_management_app/shared/widgets/custom_bottom_navbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../../course/domain/models/course_model.dart';
import '../../../home/presentation/widgets/upcoming_class_widget.dart';
import '../widgets/class_schedule_modal.dart';

@RoutePage()
class ClassScreen extends ConsumerWidget {
  const ClassScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<UpcomingClassModel>> activity =
        ref.watch(upcomingClassProvider);
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  verticalSpace(24),
                  switch (activity) {
                    AsyncData(:final value) => Visibility(
                        visible: value.isNotEmpty,
                        replacement: Column(
                          children: [
                            verticalSpace(heightSizer(165, context)),
                            SvgPicture.asset("assets/svgs/info.svg"),
                            verticalSpace(32),
                            const CustomText(
                              title: "You haven’t created any class yet.",
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
                                InkWell(
                                  onTap: () {
                                    ClassScheduleBottomSheet.show(context, ref);
                                  },
                                  child: Ink(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
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
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      onTap: () {
                                        Course course = Course(
                                          title: "Introduction to Computer",
                                        );
                                        context.pushRoute(
                                            SingleClassRoute(course: course));
                                      },
                                      child: UpcomingClassWidget(
                                        model: value[0],
                                      ),
                                    ),
                                separatorBuilder: (ctx, idx) =>
                                    verticalSpace(24),
                                itemCount: 2),
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
    );
  }
}
